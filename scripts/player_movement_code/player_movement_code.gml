function player_movement_code() {
	// Determine the direction that the player should be facing toward
	if (move_x == 1)
		player_facing = Facing.RIGHT;
	else if (move_x == -1)
		player_facing = Facing.LEFT;

	if (move_y == 1)
		player_facing = Facing.DOWN;
	else if (move_y == -1)
		player_facing = Facing.UP;

	// Switch to the idle state if we're not moving anywhere; otherwise, set the image_speed so we can animate walking
	if (move_y == 0 && move_x == 0) {
		if (instance_exists(RoomTransition) && RoomTransition.fade_state == 1) {
			if (state == PStates.IDLE) {
				state = PStates.MOVING;
				img_index = 0;
			}

			// Update the player's trail buffer
			update_player_trail_buffer();

			// Set walking animation speed
			img_speed = 0.1 * run_multiplier;
		} else {
			state = PStates.IDLE;
			img_index = 1;
			img_speed = 0;
		}
	} else {
		if (state == PStates.IDLE) {
			state = PStates.MOVING;
			img_index = 0;
		}

		// Update the player's trail buffer
		update_player_trail_buffer();

		// Set walking animation speed
		img_speed = 0.1 * run_multiplier;
	}


	if (!knocked_back) {
		hsp = move_x * move_speed * run_multiplier;
		vsp = move_y * move_speed * run_multiplier;
	} else {
		hsp *= 0.8;
		vsp *= 0.8;
	
		if (abs(hsp) <= 0.5)
			hsp = 0;
		if (abs(vsp) <= 0.5)
			vsp = 0;
		if (hsp == 0 && vsp == 0)
			knocked_back = false;
	}

	facing_x = 1;
	facing_y = 1;

	if (hsp != 0)
		facing_x = sign(hsp);
	if (vsp != 0)
		facing_y = sign(vsp);

	var _c_leniency = 3;

	// Corner cutting (Horizontal)
	if (Game.holding_key_up && move_x == 0) {
	    if (position_meeting(bbox_right, bbox_top - _c_leniency, ParentSolid) && !position_meeting(bbox_left, bbox_top - _c_leniency, ParentSolid))
			hsp -= 1; // bottom-left rounded corner
	    else if (position_meeting(bbox_left, bbox_top - _c_leniency, ParentSolid) && !position_meeting(bbox_right, bbox_top - _c_leniency, ParentSolid))
			hsp += 1; // bottom-right rounded corner
	} else if (Game.holding_key_down && move_x == 0) {
	    if (position_meeting(bbox_right, bbox_bottom + _c_leniency, ParentSolid) && !position_meeting(bbox_left, bbox_bottom + _c_leniency, ParentSolid))
			hsp -= 1; // top-left rounded corner
	    else if (position_meeting(bbox_left, bbox_bottom + _c_leniency, ParentSolid) && !position_meeting(bbox_right, bbox_bottom + _c_leniency, ParentSolid))
			hsp += 1; // top-right rounded corner
	}

	// Corner cutting (Vertical) 
	if (Game.holding_key_left && move_y == 0) {
	    if (position_meeting(bbox_left - _c_leniency, bbox_bottom, ParentSolid) && !position_meeting(bbox_left - _c_leniency, bbox_top, ParentSolid))
			vsp = -1; // top-left rounded corner
	    else if (position_meeting(bbox_left - _c_leniency, bbox_top, ParentSolid) && !position_meeting(bbox_left - _c_leniency, bbox_bottom, ParentSolid))
			vsp = 1; // bottom-left rounded corner
	} else if (Game.holding_key_right && move_y == 0) {
	    if (position_meeting(bbox_right + _c_leniency, bbox_bottom, ParentSolid) && !position_meeting(bbox_right + _c_leniency, bbox_top, ParentSolid))
			vsp = -1; // top-right rounded corner
	    else if (position_meeting(bbox_right + _c_leniency, bbox_top, ParentSolid) && !position_meeting(bbox_right + _c_leniency, bbox_bottom, ParentSolid))
			vsp = 1; // bottom-right rounded corner
	}

	// Vertical
	repeat(abs(vsp)) {
		if (place_meeting(x, y + sign(vsp), ParentSolid)) { // Is pixel below occupied?
			if (!place_meeting(x - 1, y + sign(vsp), ParentSolid)) // NOT pixel down and to the left
				x--; // Move left ONCE
			else if (!place_meeting(x + 1, y + sign(vsp), ParentSolid)) // NOT pixel down and to the right
				x++; // Move right ONCE	
			else if (!place_meeting(x - 2, y + sign(vsp), ParentSolid)) // Pixel down-left, NOT pixel down+2 left
				x -= 2; // Move left TWICE
			else if (!place_meeting(x + 2, y + sign(vsp), ParentSolid)) // Pixel down-right, NOT pixel down+2 right
				x += 2; // Move right TWICE
		
		}
		// Handle solid walls in general
		if (!place_meeting(x, y + sign(vsp), ParentSolid))
		    y += sign(vsp); 
		else {
		    vsp = 0;
		    break;
		}
	}

	// Horizontal

	repeat(abs(hsp)) {
		if (place_meeting(x + sign(hsp), y, ParentSolid)) { // Is pixel to the left/right occupied?
			if (!place_meeting(x + sign(hsp), y - 1, ParentSolid)) // NOT pixel up and to the left/right
				y--; // Move up ONCE
			if (!place_meeting(x + sign(hsp), y + 1, ParentSolid)) // NOT pixel down and to the left/right
				y++; // Move down ONCE
			else if (!place_meeting(x + sign(hsp), y - 2, ParentSolid)) // Pixel 1 up, 1 left/right; NOT pixel 2 up + 1 left/right
				y -= 2; // Move up TWICE
			else if (!place_meeting(x + sign(hsp), y + 2, ParentSolid)) // Pixel 1 down, 1 left/right; NOT pixel 2 down + 1 left/right
				y += 2; // Move down TWICE
		}
		// Handle solid walls in general
	    if (!place_meeting(x + sign(hsp), y, ParentSolid))
	        x += sign(hsp); 
	    else {
	        hsp = 0;
	        break;
	    }
	}

	// Handle animations
	switch(player_facing) {
		default:
		case Facing.DOWN:
			img_index_offset = 0;
			break;
		case Facing.LEFT:
			img_index_offset = 4;
			break;
		case Facing.UP:
			img_index_offset = 8;
			break;
		case Facing.RIGHT:
			img_index_offset = 12;
			break;
	}

	// Allow the player to push the camera around
	update_push_camera();

	// Debug stuff
	if (Game.debug) {
		if (mouse_check_button(mb_left)) {
			knocked_back = true;
			var _dir = point_direction(Player.x, Player.y, mouse_x, mouse_y);
			hsp = -lengthdir_x(10, _dir);
			vsp = -lengthdir_y(10, _dir);
		}

		if (mouse_check_button(mb_right))
		{
		    x = round(mouse_x);
		    y = round(mouse_y);
		}
	}


}

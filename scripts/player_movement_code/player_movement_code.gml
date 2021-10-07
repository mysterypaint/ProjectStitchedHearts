function player_movement_code() {
	move_x = -Game.holding_key_left + Game.holding_key_right;
	move_y = -Game.holding_key_up + Game.holding_key_down;

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
		state = PStates.IDLE;
		img_index = 1;
		img_speed = 0;
	} else {
		if (state == PStates.IDLE) {
			state = PStates.MOVING;
			img_index = 0;
		}

		// Update the trail buffer
		for (var i = ally_trail_buffer - 1; i > 0; i--) {
		    trail_buffer_x[i] = trail_buffer_x[i-1];
		    trail_buffer_y[i] = trail_buffer_y[i-1];
			img_index_buffer[i] = img_index_buffer[i-1];
			img_index_offset_buffer[i] = img_index_offset_buffer[i-1];
		}
	
		// Store the player's current position at the front of the array
		trail_buffer_x[0] = x;
		trail_buffer_y[0] = y;
		img_index_buffer[0] = img_index;
		img_index_offset_buffer[0] = img_index_offset;

		// Set walking animation speed
		img_speed = 0.1;
	}

	// Determine the speed the player should attempt to move by
	hsp = move_x * move_speed;
	vsp = move_y * move_speed;

	// Handle collision detection
	// TODO


	// Move the player
	x += hsp;
	y += vsp;

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

	update_push_camera();


}

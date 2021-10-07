function update_push_camera() {
	var _win_width = Game.win_width;
	var _win_height = Game.win_height;
	var _push_boundary_left = 105;
	var _push_boundary_top = 50;
	var _push_boundary_right = _win_width - _push_boundary_left;
	var _push_boundary_bottom = _win_height - _push_boundary_top;
	var _player_height = 35 - 1;

	if (instance_exists(Camera)) {
		// Update the camera position
		if (x + hsp > Camera.x + _push_boundary_right)
			Camera.x = x + hsp - _push_boundary_right;
		else if (x + hsp < Camera.x + _push_boundary_left)
			Camera.x = x + hsp - _push_boundary_left;
	
		if (y + vsp > Camera.y + _push_boundary_bottom)
			Camera.y = y + vsp - _push_boundary_bottom;
		else if (y + vsp < Camera.y + _push_boundary_top + _player_height)
			Camera.y = y + vsp - _push_boundary_top - _player_height;
	
		// The camera should never go out of the room bounds
		if (Camera.x + _win_width > room_width)
			Camera.x = room_width - _win_width;
		else if (Camera.x < 0)
			Camera.x = 0;
		
		if (Camera.y + _win_height > room_height)
			Camera.y = room_height - _win_height;
		else if (Camera.y < 0)
			Camera.y = 0;

		// Update the viewport
		camera_set_view_pos(view_camera[0], Camera.x, Camera.y);
	}


}

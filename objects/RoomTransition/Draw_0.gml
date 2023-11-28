/// @description Draw fade
fade_alpha = clamp(fade_alpha + (fade_state * fade_speed), 0, 1);
if (fade_alpha == 1) {
	room_goto(temp_target);
	with (Player) {
		hsp = 0;
		vsp = 0;
		img_index = 1;
		img_speed = 0;
		move_x = 0;
		move_y = 0;
		lock_move_x = 0;
		lock_move_y = 0;
		x = player_x;
		y = player_y;
		
		// Reset the NPC trail buffer to reflect the player's new position on the map.
		for(var i = ally_trail_buffer - 1; i >= 0; i--){
		    trail_buffer_x[i] = x;
		    trail_buffer_y[i] = y;
			img_index_buffer[i] = img_index;
			img_index_offset_buffer[i] = img_index_offset;
		}
	}
	fade_state = -1;
}

if (fade_alpha == 0 && fade_state == -1) {
	Game.state = Game.prev_state;
	if (Game.state == GameStates.GAMEPLAY)
		Player.state = PStates.IDLE;
	instance_destroy();
}

draw_set_color(c_black);
draw_set_alpha(fade_alpha);
draw_rectangle(Camera.x, Camera.y, Camera.x + Game.win_width, Camera.y + Game.win_height, false);
draw_set_alpha(1);
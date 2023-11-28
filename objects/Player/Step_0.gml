/// @description Player logic
event_inherited();

if (instance_exists(RoomTransition)) {
	move_x = lock_move_x;
	move_y = lock_move_y;
	player_movement_code();
} else {
	switch (state) {
		case PStates.IDLE:
			player_get_input();
			player_movement_code();
			break;
		case PStates.MOVING:
			player_get_input();
			player_movement_code();
			break;
	}
}

// Add a small delay between textbox triggers
if (!instance_exists(Textbox)) {
	if (talk_buffer > 0)
		talk_buffer--;
}
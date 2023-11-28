/// @description Move between rooms
if (!instance_exists(RoomTransition)) {
	Game.prev_state = Game.state;
	Game.state = GameStates.CHANGING_MAP;
	player_x = other.target_x + 8;
	player_y = other.target_y + (bbox_bottom - bbox_top) + 10;	
	lock_move_x = move_x;
	lock_move_y = move_y;
	sfx_play(sfx_ChangeMap, 0, false);
	var _temp_room_fade;
	_temp_room_fade = instance_create_depth(x, y, 0, RoomTransition);
	_temp_room_fade.temp_target = other.target_room;
}
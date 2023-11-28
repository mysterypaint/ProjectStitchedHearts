function player_get_input() {
	move_x = Game.holding_key_right - Game.holding_key_left;
	move_y = Game.holding_key_down - Game.holding_key_up;

	if (Game.holding_key_run)
	    run_multiplier = 2;
	else
	    run_multiplier = 1;


}

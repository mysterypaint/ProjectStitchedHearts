/// @description Game logic

switch(state) {
	case GameStates.INIT:
		window_set_size(win_width * window_size, win_height * window_size);
		alarm[0] = 1;
		
		loaded_text = ds_create("loaded_text", DS.MAP);
		ltext_line_count = ds_create("ltext_line_count", DS.MAP);
		player = instance_create_depth(160, 96, -80, Player);
		
		lines_skipped = 0;//get_integer("Start reading .txt from line:", "");
		load_text("game_text.txt", lines_skipped); // Stores all the game's text to Game.loaded_text, and all the line counts to Game.ltext_line_count as two separate ds_maps

		state = GameStates.ABOUT_SCREEN; //GameStates.GAMEPLAY;
		break;
	case GameStates.ABOUT_SCREEN:
		if (pressed_key_confirm) {
			state = GameStates.GAMEPLAY;
			room_goto(SchoolPonBedroom);
			cam_obj = instance_create_depth(0, 0, 1, Camera);
		}
		break;
	case GameStates.GAMEPLAY:
		break;
	case GameStates.CUTSCENE:
		break;
}

if (keyboard_check_pressed(vk_f7)) {
	window_size++;
	if (window_size > window_size_max)
		window_size = 1;
	window_set_size(win_width * window_size, win_height * window_size);
	alarm[0] = 1;
}

// (Alt + Enter) or F4 = Toggle fullscreen
if ((keyboard_check_pressed(vk_enter) && keyboard_check(vk_alt)) || keyboard_check_pressed(vk_f4))
	window_set_fullscreen(!window_get_fullscreen());

if (keyboard_check_pressed(vk_escape))
	game_end();

// Debug mode toggling, if applicable.
if (debug_toggling) {
	if (keyboard_check_pressed(ord("Q")))
		debug = !debug;
}

ticks++;
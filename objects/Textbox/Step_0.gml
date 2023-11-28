/// @description Textbox logic
x = Camera.x;
y = Camera.y;

/// Parse and execute the dialogue script
if (Game.state == GameStates.PAUSED || Game.prev_state == GameStates.PAUSED)
	exit;

if (moving_cutscene) {
	if (!terminate && (tbox_y_offset == 0 || tbox_y_offset == -128 || tbox_y_offset == 128)) {
		moving_bottom = true;//player_above_or_below_textbox();
	}
} else {
	moving_bottom = true;
}

if (moving_bottom) {
	if (slide_in) { // Lower textbox sliding into the screen
		if (tbox_y_offset > 0)
			tbox_y_offset -= 16;
		else
			tbox_y_offset = 0;
	} else {
		if (tbox_y_offset < 128)
			tbox_y_offset += 16;
		else
			tbox_y_offset = 128;
	}
} else {
	if (slide_in) { // Lower textbox sliding into the screen, but with top textbox behavior
		if (tbox_y_offset < 0)
			tbox_y_offset += 16;
		else
			tbox_y_offset = 0;
	} else {
		if (tbox_y_offset > -128)
			tbox_y_offset -= 16;
		else
			tbox_y_offset = -128;
	}
}


if (slide_in_t) { // Upper textbox sliding into the screen
	if (tbox_y_offset_t < 0)
		tbox_y_offset_t += 16;
	else
		tbox_y_offset_t = 0;
} else {
	if (tbox_y_offset_t > -128)
		tbox_y_offset_t -= 16;
	else
		tbox_y_offset_t = -128;
}

if (((moving_bottom && !slide_in && tbox_y_offset >= 128) || (!moving_bottom && !slide_in && tbox_y_offset <= -128)) && !slide_in_t && tbox_y_offset_t <= -128 && terminate) {
	instance_destroy();
}

var _p_advance_text = Game.pressed_key_confirm;//device_mouse_check_button_pressed(0, mb_left); // Debug; Remap to what the game actually uses
var _p_skip_text = max(Game.holding_key_cancel, Game.holding_key_run, 0);//device_mouse_check_button_pressed(0, mb_right); // Debug; Remap to what the game actually uses

if (curr_loaded_line_count < loaded_text_line_count) {
	if (new_line) { // Prepare to draw a totally new textbox
		new_line = false; // Only reset by the player or in-script
		loaded_text = string_split(loaded_text, "\n");
		curr_line = loaded_text[curr_loaded_line_count]; // Load the current line from the script we have loaded in memory
		if (!is_undefined(curr_line) && !broke)
			curr_line = string_replace_all(curr_line, chr(35), "\n"); // GameMaker why
		
		if (bottom) { // Clear the bottom textbox
			curr_drawn_text_b = "";
			ds_list_clear(char_font);
			ds_list_clear(char_max_width);
			ds_list_clear(char_max_height);
			ds_list_clear(char_color);
			ds_list_clear(char_shake_magnitude);
			ds_list_clear(char_x_offset);
			ds_list_clear(char_y_offset);
			ds_list_clear(char_sine_amp_x);
			ds_list_clear(char_sine_amp_y);
			ds_list_clear(char_sine_per_x);
			ds_list_clear(char_sine_per_y);
		}
		else {// Otherwise, clear the top textbox instead
			curr_drawn_text_t = "";
			ds_list_clear(char_font_t);
			ds_list_clear(char_max_width_t);
			ds_list_clear(char_max_height_t);
			ds_list_clear(char_color_t);
			ds_list_clear(char_shake_magnitude_t);
			ds_list_clear(char_x_offset_t);
			ds_list_clear(char_y_offset_t);
			ds_list_clear(char_sine_amp_x_t);
			ds_list_clear(char_sine_amp_y_t);
			ds_list_clear(char_sine_per_x_t);
			ds_list_clear(char_sine_per_y_t);
		}

		curr_line_char_count = 0; // Current number of characters we've read on the given line.
		curr_line_dchar_count = 0; // Current number of characters in the currently-drawing line on the screen.	
		linebreak_count = 0;
		x_offset = 0;
		y_offset = 0;
	}
}
if (delay_timer <= 0) { // Have we waited long enough?
	delay_timer = 0;
	enable_voice = true;
	var _did_linebreak = false;
	if (curr_loaded_line_count < loaded_text_line_count) { // Are we at the end of the line already?
		if (advance) { // Are we waiting for something before continuing the dialogue?
			// It's time to parse the next character in the sentence.
			if (curr_line_char_count < string_length(curr_line)) {
				if (curr_line_char_count == 0)
					continue_bottom = bottom; // Immediately determine whether the continue prompt should show up at the bottom or top of the text.
				var _this_char = string_char_at(curr_line, curr_line_char_count + 1);
				
				switch(_this_char) {
					case chr(12):
						// Don't do anything for pagebreaks (added for collab reasons)
						break;
					case chr(124): // A | in the script will lag it by 4 frames. Stack a bunch to create pauses in the dialogue.
						enable_voice = false;
						delay_timer += 4;
						break;
					case chr(91): // The beginning of a control code, the [
						enable_voice = false;
						curr_line_char_count = get_dialog_control_code(curr_line, curr_line_char_count); // Parses and executes control codes, then skips over everything in-between.
						break;
					case chr(10):
					case chr(20):
						enable_voice = false;
						if (curr_line_char_count < string_length(curr_line)-1)
							linebreak_count++;
						x_offset = 0;
						curr_line_dchar_count = 0;
						_did_linebreak = true;
					case "’":
					case "“":
					case "”":
						switch (_this_char) {
							case "’":
								_this_char = chr(39); // Regular apostrophe
								break;
							case "“":
							case "”":
								_this_char = "\"";
								break;
						}
					case chr(39):
					case ".":
					case "!":
					case "?":
					case ",":
					case "(":
					case ")":
					case "*":
					case " ":
					case "\"":
					case "~":
						enable_voice = false;
					default:
						if (bottom) { // Amend character to bottom textbox
							force_color_b = false;
							curr_drawn_text_b += _this_char;
						}
						else {// Otherwise, amend it to the top textbox instead
							force_color_t = false;
							curr_drawn_text_t += _this_char;
						}
						curr_line_dchar_count++;
						y_offset = ((curr_max_height + 2) * linebreak_count);

						// Parallel arrays for loaded_text to store data for every character for drawing
						
						if (bottom) {
							ds_list_add(char_font, curr_font);
							ds_list_add(char_max_width, curr_max_width);
							ds_list_add(char_max_height, curr_max_height);
							ds_list_add(char_color, color);
							ds_list_add(char_shake_magnitude, shake_magnitude);
							ds_list_add(char_x_offset, x_offset);
							ds_list_add(char_y_offset, y_offset);
							ds_list_add(char_sine_amp_x, tbox_sine_amp_x);
							ds_list_add(char_sine_amp_y, tbox_sine_amp_y);
							ds_list_add(char_sine_per_x, tbox_sine_per_x);
							ds_list_add(char_sine_per_y, tbox_sine_per_y);
						} else {
							ds_list_add(char_font_t, curr_font);
							ds_list_add(char_max_width_t, curr_max_width);
							ds_list_add(char_max_height_t, curr_max_height);
							ds_list_add(char_color_t, color_t);
							ds_list_add(char_shake_magnitude_t, shake_magnitude);
							ds_list_add(char_x_offset_t, x_offset);
							ds_list_add(char_y_offset_t, y_offset);
							ds_list_add(char_sine_amp_x_t, tbox_sine_amp_x);
							ds_list_add(char_sine_amp_y_t, tbox_sine_amp_y);
							ds_list_add(char_sine_per_x_t, tbox_sine_per_x);
							ds_list_add(char_sine_per_y_t, tbox_sine_per_y);
						}

						if (!_did_linebreak) {
							if (!monospace) { // Correct VWF spacing, if it's enabled for this char
								//if (ds_map_exists(vwf_map, _this_char))
								//	x_offset += vwf_map[? _this_char];
								//else
								//	x_offset += 8;
								
								x_offset += (8 - ds_list_find_value(Game.fnt_width, ord(_this_char)));//string_width(_this_char);//_key_width;//Game.dlg_fnt_width[| _this_key];//ds_map_find_value(Game.dlg_fnt_width, _this_char); //string_width(_this_char);
								
							}
							else {
								x_offset += string_width(_this_char);
							}
						}
						
						delay_timer += 2;
						
						var _sfx_voice = asset_get_index(curr_voice);
						audio_stop_sound(_sfx_voice);
						if (enable_voice && curr_voice != "none" && !audio_is_playing(_sfx_voice)) {
							audio_play_sound(_sfx_voice, 0, false);
							if (bottom)
								mouth_frame_index_bottom++;
							else
								mouth_frame_index_top++;
						} else {
							if (bottom)
								mouth_frame_index_bottom = 0;
							else
								mouth_frame_index_top = 0;
						}
						break;
				}
				curr_line_char_count++;
			} else
				advance = false;
		}
	}	
} else
	delay_timer -= curr_spd * Game.dt;
if (_p_skip_text && can_control)
	delay_timer = 0; // Override any delay between characters if we're holding the text speedup button

if ((_p_advance_text) && can_control && !advance) {
	if (nametag_on)
		Game.log += curr_nametag + ": ";
	Game.log += curr_drawn_text_b + "\n";
	//if (curr_loaded_line_count <= loaded_text_line_count) {
	delay_timer = 0;
	new_line = true;
	advance = true;
	if (curr_loaded_line_count + 1 < loaded_text_line_count && !end_early) {
		curr_loaded_line_count++;
	} else {
		instance_destroy();
	}
	linebreak_count = 0;
	x_offset = 0;
	curr_line_dchar_count = 0;
	line_time = 0;
}

// Handle global textbox shaking
if (tbox_shake_mag > 0) {
	tbox_shake_mag-=4;
	tbox_shake_x = irandom_range(-tbox_shake_mag, tbox_shake_mag);
	tbox_shake_y = irandom_range(-tbox_shake_mag, tbox_shake_mag);
} else {
	tbox_shake_mag = 0;
	tbox_shake_x = 0;
	tbox_shake_y = 0;
}

time_alive += 1 * Game.dt;
line_time += 1 * Game.dt;
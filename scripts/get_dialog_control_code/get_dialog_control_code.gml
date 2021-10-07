/// @description get_dialog_control_code
function get_dialog_control_code(argument0, argument1) {
	// This script parses and executes code, triggered by a [ in the dialogue. It will return the number of characters it took to reach the ]
	/// @param line_to_read
	/// @param current_line_position

	var _line_to_read = argument0;
	var _curr_line_pos = argument1 + 2;
	var _control_command = "";
	var _control_command_end = false;
	var _control_set_off = false;
	var _control_arguments = ds_create("_control_arguments", DS.LIST);

	if (string_char_at(_line_to_read, _curr_line_pos) == chr(47)) { // If we hit a / immediately, we know the control code's trying to disable something.
		_control_set_off = true;
		_curr_line_pos++;
	}

	while (_curr_line_pos < string_length(_line_to_read)) {
		var _this_char = string_char_at(_line_to_read, _curr_line_pos);
		if (_this_char == chr(93))
			break; // The end of a control code, the ]
		if (_this_char == chr(58)) { // The end of a control command, the :
			_control_command_end = true;
			_curr_line_pos++;
		}
		if (!_control_command_end)
			_control_command += _this_char;
		else {
			// Grabbing all control code arguments here
			var _value_found = "";
			while (string_char_at(_line_to_read, _curr_line_pos) != chr(93) && string_char_at(_line_to_read, _curr_line_pos) != chr(44)) { // While we haven't hit a comma or a ] ...
				_value_found += string_char_at(_line_to_read, _curr_line_pos);			
				_curr_line_pos++;
			}
			ds_list_add(_control_arguments, _value_found);
		}
		if (string_char_at(_line_to_read, _curr_line_pos) == chr(93)) break;
		_curr_line_pos++;
	}


	// All the "out" stuff below is for debugging purposes, using the console output.

	if (_control_set_off) var _out = "Disable ";
	else var _out = "Enable ";

	_out += _control_command + ". Arguments: (";

	if (ds_list_size(_control_arguments) <= 0 ) _out += "none)";
	else {
		for (var i = 0; i < ds_list_size(_control_arguments); i++) {
			_out +=  ds_list_find_value(_control_arguments, i);
			if (i+1 >= ds_list_size(_control_arguments)) _out += ")";
			else _out += ", ";
		}
	}

	show_debug_message(_out); // It works!

	// Now, we need to make meaning out of all these commands.

	switch (_control_command) {
		case "P_IMG_SPEED": // This will set the image speed of the player
			var _arg0 = ds_list_find_value(_control_arguments, 0);
			Player.img_speed = real(_arg0);
			break;
		case "P_IMG_INDEX": // This will set the image index of the player
			var _arg0 = ds_list_find_value(_control_arguments, 0);
			Player.img_index = real(_arg0);
			break;
		case "P_SPR_INDEX": // This will set the sprite index of the player
			var _arg0 = ds_list_find_value(_control_arguments, 0);
			Player.spr_index = asset_get_index(_arg0);
			break;
		case "i": // This will toggle italicized fonts
			if (!_control_set_off) {
				curr_font = Fonts.DLG_I;
			}
			else
				curr_font = Fonts.DLG;
			break;
		case "SUB": // This will change font drawing to "subtitle mode": no box in the background, and text will be centered in the middle of the screen
			if (!_control_set_off) {
				subtext_mode = true;
			}
			else
				subtext_mode = false;
			break;
		case "P_STATE": // This forces the player's state in the player's own state machine
			var _arg0 = ds_list_find_value(_control_arguments, 0);
			switch(_arg0) {
				case "IDLE":
					Player.state = pstates.IDLE;
					break;
				case "CUTSCENE":
					Player.state = pstates.CUTSCENE;
					break;
				case "SLAMMING_DESK":
					Player.state = pstates.SLAMMING_DESK;
					break;
				case "SPIT_TAKE":
					Player.state = pstates.SPIT_TAKE;
					PropBellTea.img_index = 1;
					PropBellTea.visible = true;
					break;
				case "CS_JUMPING":
					Player.state = pstates.CS_JUMPING;
					Player.cs_jump_timer = 0;
					break;
			}
			break;
		case "EVENT": // Handle event triggers. I can hardcode whether these activate as soon as this switch ends, or as soon as the player closes the textbox.
			var _this_event = instance_create_layer(0, 0, "LayerEffects", EventController);
			_this_event.event = ds_list_find_value(_control_arguments, 0);
			_this_event.parent_id = id;
			break;
		case "COL": // Set the text Color
			if (!_control_set_off) {
			var _thisCol = ds_list_find_value(_control_arguments, 0);
			if (_thisCol == "nar") // Special case for internalized dialogue color
				color = make_color_rgb(104, 192, 253);
			else if (_thisCol == "c_red")
				color = c_red;
			else if (_thisCol == "c_green")
				color = make_color_rgb(0, 230, 103);
			else
				color = _thisCol;
			} else
				color = c_white;
			break;
		case "COL_T": // Text Color (upper textbox)
			if (!_control_set_off) {
			var _thisCol = ds_list_find_value(_control_arguments, 0);
			if (_thisCol == "nar") // Special case for internalized dialogue color
				color_t = make_color_rgb(104, 192, 253);
			else if (_thisCol == "c_red")
				color = c_red;
			else if (_thisCol == "c_green")
				color = c_green;
			else
				color_t = _thisCol;
			} else
				color_t = c_white;
			break;
		case "TOP": // Select whether we're writing to the top or bottom textbox
			if (!_control_set_off)
				bottom = false;
			else
				bottom = true;
			break;
		case "B_TEXT_F": // Force-change the text on the bottom textbox
			curr_drawn_text_b = ds_list_find_value(_control_arguments, 0);
			var _thisCol = ds_list_find_value(_control_arguments, 1);
			if (_thisCol == "nar") // Special case for internalized dialogue color
				color_f_b = make_color_rgb(104, 192, 253);
			else
				color_f_b = _thisCol;
			force_color_b = true;
			break;
		case "T_TEXT_F": // Force-change the text on the top textbox
			curr_drawn_text_t = ds_list_find_value(_control_arguments, 0);
			var _thisCol = ds_list_find_value(_control_arguments, 1);
			if (_thisCol == "nar") // Special case for internalized dialogue color
				color_f_t = make_color_rgb(104, 192, 253);
			else
				color_f_t = _thisCol;
			force_color_t = true;
			break;
		case "ALTPORT": // Select whether we're writing to the top or bottom textbox
			if (!_control_set_off) {
				if (!instance_exists(PropNPCPortLeft))
					instance_create_depth(x + 350, y + 490 + 8, -200, PropNPCPortLeft);
				if (!instance_exists(PropNPCPortRight))
					instance_create_depth(x + 850 +170, y + 490 + 8, -201, PropNPCPortRight);
				alt_port_mode = true;
			}
			else {
				alt_port_mode = false;
			}
			break;
		case "PORT_IMG_INDEX": // If ALTPORT is enabled, this will set the sprite for the NPC graphic on the left of the screen
			if (instance_exists(PropNPCPortLeft))
				PropNPCPortLeft.img_index = real(ds_list_find_value(_control_arguments, 0));
			break;
		case "PORT_T_IMG_INDEX": // Same as above, but for the Right side's NPC graphic
			if (instance_exists(PropNPCPortRight))
				PropNPCPortRight.img_index = real(ds_list_find_value(_control_arguments, 0));
			break;
		case "PORT": // Portrait pic for lower textbox, if ALTPORT is disabled (also toggles if it should show/hide it)
			if (!_control_set_off) {
				port_on = true;
				var _port_str_name = ds_list_find_value(_control_arguments, 0);
				if (!alt_port_mode)
					curr_port_ind = get_port_enum(_port_str_name);
				else
					curr_port_ind = asset_get_index(_port_str_name);
			}
			else
				port_on = false;
			break;
		case "PORT_T": // Portrait pic for upper textbox, if ALTPORT is disabled (also toggles if it should show/hide it)
			if (!_control_set_off) {
				port_on_t = true;
				var _port_str_name = ds_list_find_value(_control_arguments, 0);
				if (!alt_port_mode)
					curr_port_ind_t = get_port_enum(_port_str_name);
				else
					curr_port_ind_t = asset_get_index(_port_str_name);
			}
			else
				port_on_t = false;
			break;
		case "NAME": // Nametag on bottom textbox (also toggles if it should show/hide it)
			if (!_control_set_off) {
				nametag_on = true;
				curr_nametag = ds_list_find_value(_control_arguments, 0);
			}
			else
				nametag_on = false;
			break;
		case "NAME_T": // Nametag on upper textbox (also toggles if it should show/hide it)
			if (!_control_set_off) {
				nametag_on_t = true;
				curr_nametag_t = ds_list_find_value(_control_arguments, 0);
			}
			else
				nametag_on_t = false;
			break;
		case "V": // Current text voice sfx to use
			if (!_control_set_off)
				curr_voice = ds_list_find_value(_control_arguments, 0);
			else
				curr_voice = "none";
			break;
		case "VWF": // Toggles VWF (either on or off)
			if (!_control_set_off)
				monospace = false;
			else
				monospace = true;
			break;
		case "TSHAKE": // Shakey text. Only argument is magnitude
			if (!_control_set_off)
				tbox_shake_mag = real(ds_list_find_value(_control_arguments, 0));
			else
				tbox_shake_mag = 0;
			break;
		case "SINE": // Sinewave motion text. Takes in 4 arguments, as suggested below
			if (!_control_set_off) {
				tbox_sine_amp_x = real(ds_list_find_value(_control_arguments, 0));
				tbox_sine_amp_y = real(ds_list_find_value(_control_arguments, 1));
				tbox_sine_per_x = real(ds_list_find_value(_control_arguments, 2));
				tbox_sine_per_y = real(ds_list_find_value(_control_arguments, 3));
			}
			else {
				tbox_sine_amp_x = 0;
				tbox_sine_amp_y = 0;
				tbox_sine_per_x = 0;
				tbox_sine_per_y = 0;
			}
			break;
		case "SHAKE": // Shake the character drawn (arg0: magnitude)
			if (!_control_set_off)
				shake_magnitude = real(ds_list_find_value(_control_arguments, 0));
			else
				shake_magnitude = 0;
			break;
		case "SFX": // Force-play an SFX
			var _fname = ds_list_find_value(_control_arguments, 0) + ".ogg";
			show_debug_message(_fname);
			var _sfx_play = asset_get_index(ds_list_find_value(_control_arguments, 0));
			if (!_control_set_off)
				audio_play_sound(_sfx_play, real(ds_list_find_value(_control_arguments, 1)), real(ds_list_find_value(_control_arguments, 2)));
			else
				audio_stop_sound(_sfx_play);
			break;
		case "BGMP": // Pauses/resumes the current song
			if (!_control_set_off)
				audio_pause_sound(global.curr_bgm);
			else
				audio_resume_sound(global.curr_bgm);
			break;
		case "BGM": // Stops any previous BGM and plays the one defined. Arguments exactly like audio_play_sound().
			//var _bgm_play = asset_get_index(ds_list_find_value(_control_arguments, 0));
			if (!_control_set_off) {
				var _fnamebgm = working_directory + "bgm\\" + ds_list_find_value(_control_arguments, 0) + ".ogg";
				if (audio_is_playing(global.curr_bgm)) {
					audio_destroy_stream(global.curr_bgm);
				}
				global.curr_bgm = audio_create_stream(_fnamebgm);
				audio_play_sound(global.curr_bgm, real(ds_list_find_value(_control_arguments, 1)), real(ds_list_find_value(_control_arguments, 2)));
			} else {
				audio_stop_sound(global.curr_bgm);
				audio_destroy_stream(global.curr_bgm);
			}
			break;
		case "A": // Automatically advance the text. Arg0: Adds x ticks to the delay timer [pretty sure this arg doesn't work actually lol, use Dxx instead. See the next command]
			if (end_early)
				instance_destroy();
			new_line = true;
			advance = true;
			curr_loaded_line_count++;
			break;
		case "D": // Delays for x ticks before moving on.
			if (ds_list_size(_control_arguments) > 0)
				delay_timer += real(ds_list_find_value(_control_arguments, 0));
			break;
		case "S": // Controls the text speed (the delay between characters) [I think this is a little broken. Unsure if we need to make it any faster but I can come back to this if we do]
			if (ds_list_size(_control_arguments) > 0)
				curr_spd = real(ds_list_find_value(_control_arguments, 0));
			break;
		case "NOPE": // Disable player's ability to control the text engine at all (no speedup, no advance)
			if (!_control_set_off)
				can_control = false;
			else
				can_control = true;
			break;
		case "END": // Aborts the textbox currently being read. Absolutely necessary to end every textbox with this, because every linebreak is a different set of dialogue.
			end_early = true;
			break;
		default:
			break;
	}

	ds_list_destroy(_control_arguments);
	return _curr_line_pos-1;


}

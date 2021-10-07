/// @description The regular textbox drawing routine
function draw_textbox() {

	var _tbox_boffset_x = 0;
	var _tbox_boffset_y = 0;

	/*

	// Handle eye animation

	if (blink_wait_timer_bottom <= 0) {
		if (Game.ticks % get_frames(0.05) == 0) {
			if (eye_frame_index_bottom == 3) {
				blink_wait_timer_bottom = get_frames(0.5 + random(3.5));
				eye_frame_index_bottom = 0;
			} else {
				eye_frame_index_bottom++;
			}
		}
	} else {
		blink_wait_timer_bottom--;
	}

	if (blink_wait_timer_top <= 0) {
		if (Game.ticks % get_frames(0.05) == 0) {
			if (eye_frame_index_top == 3) {
				blink_wait_timer_top = get_frames(0.5 + random(3.5));
				eye_frame_index_top = 0;
			} else {
				eye_frame_index_top++;
			}
		}
	} else {
		blink_wait_timer_top--;
	}

	*/

	//draw_sprite(spr_TextBoxBack, 0, x + _tbox_boffset_x + 128 + tbox_shake_x, y + _tbox_boffset_y + (Game.win_height / 2) + 64 + tbox_shake_y);

	var _upperbox_offset = 0;

	//+ ((linebreak_count) * curr_max_height)    // sprTextboxContinue offsetting by linebreak count
	// Draw the "allowed to proceed dialogue" arrow
	if (curr_line_char_count >= string_length(curr_line) && advance == false) {
		if (continue_bottom) { // Animate sprTextboxContinue for top and bottom textboxes, separately
			if (Game.ticks % get_frames(0.072) == 0)
				continueBottomIndex++;
		} else {
			if (Game.ticks % get_frames(0.072) == 0)
				continueTopIndex++;
		}
	
		if (bottom)
			draw_sprite_ext(sprTextboxContinue, continueBottomIndex % 6, x + _tbox_boffset_x + 301 + tbox_shake_x, y + _tbox_boffset_y + 171 - tbox_shake_y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
		else if (!bottom)
			draw_sprite_ext(sprTextboxContinue, continueTopIndex % 6, x + _tbox_boffset_x + 301 + tbox_shake_x, y + _tbox_boffset_y + 171  - _upperbox_offset - tbox_shake_y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

		// At the end of each dialogue, nobody's mouths should be moving
		//mouth_frame_index_bottom = 0;
		//mouth_frame_index_top = 0;
	} else { // Reset sprTextboxContinue animations	
		continueTopIndex = 0;
		continueBottomIndex = 0;
	}

	if (Game.dt > 0) {
		for (var i = 0; i < string_length(curr_drawn_text_b); i++) {	
			var _sh_mag = ds_list_find_value(char_shake_magnitude, i);
			char_shake_x[| i] = irandom(_sh_mag);
			char_shake_y[| i] = irandom(_sh_mag);
		}
	}

	for (var i = 0; i < string_length(curr_drawn_text_b); i++) {
		var _d_font = ds_list_find_value(char_font, i);
		var _d_m_width = ds_list_find_value(char_max_width, i);
		var _d_m_height = ds_list_find_value(char_max_height, i);
		var _d_color = ds_list_find_value(char_color, i);
		var _d_xoff = ds_list_find_value(char_x_offset, i); // x/y offsets for text positioning
		var _d_yoff = ds_list_find_value(char_y_offset, i);
		var _shk_x = char_shake_x[| i];
		var _shk_y = char_shake_y[| i];
		if (is_undefined(_shk_x))
			_shk_x = 0;
		if (is_undefined(_shk_y))
			_shk_y = 0;
		var _sin_amp_x = ds_list_find_value(char_sine_amp_x, i);
		var _sin_amp_y = ds_list_find_value(char_sine_amp_y, i);
		var _sin_per_x = ds_list_find_value(char_sine_per_x, i);
		var _sin_per_y = ds_list_find_value(char_sine_per_y, i);
		var _sin_x = _sin_amp_x * sin((_sin_per_x * pi * (sin_tick + (i*2)) / 150));
		var _sin_y = _sin_amp_y * sin((_sin_per_y * pi * (sin_tick + (i*2)) / 150));
		var _curr_char = string_char_at(curr_drawn_text_b, i + 1);
		//shw_message(string(_sin_amp_x) + ","+string(_sin_amp_y)+","+string(_sin_per_x)+","+string(_sin_per_y));
		if is_real(_d_color)
			draw_set_color(_d_color);
		else
			draw_set_color(c_white);
	
		if (!is_real(_d_font))
			_d_font = Game.font;
	
		if (force_color_b) // Override color for bottom text if control code in game dialogue demands it
			draw_set_color(color_f_b);
	
		if (port_on) {
			//if (curr_port_ind > PortInds.BLANK)
				//draw_portraits(0, alt_port_mode);
			show_tbox_text(x + _tbox_boffset_x + 52 + _d_xoff + _shk_x + _sin_x - tbox_shake_x, y + 49 + _tbox_boffset_y + (Game.win_height / 2) + _d_yoff + _shk_y + _sin_y - tbox_shake_y, _curr_char, _d_font, _d_color);
		} else { // Draw the text onto the screen
			show_tbox_text(x + _tbox_boffset_x + 52 + _d_xoff + _shk_x + _sin_x - tbox_shake_x, y + 49 + _tbox_boffset_y + (Game.win_height / 2) + _d_yoff + _shk_y + _sin_y - tbox_shake_y, _curr_char, _d_font, _d_color);
		}
	}

	for (var i = 0; i < string_length(curr_drawn_text_t); i++) {
		var _d_font = ds_list_find_value(char_font_t, i);
		var _d_m_width = ds_list_find_value(char_max_width_t, i);
		var _d_m_height = ds_list_find_value(char_max_height_t, i);
		var _d_color = ds_list_find_value(char_color_t, i);
		var _d_xoff = ds_list_find_value(char_x_offset_t, i); // x/y offsets for text positioning
		var _d_yoff = ds_list_find_value(char_y_offset_t, i);
		var _sh_mag = ds_list_find_value(char_shake_magnitude_t, i);
		var _sin_amp_x = ds_list_find_value(char_sine_amp_x_t, i);
		var _sin_amp_y = ds_list_find_value(char_sine_amp_y_t, i);
		var _sin_per_x = ds_list_find_value(char_sine_per_x_t, i);
		var _sin_per_y = ds_list_find_value(char_sine_per_y_t, i);
		var _sin_x = _sin_amp_x * sin((_sin_per_x * pi * (sin_tick + (i*2)) / 150));
		var _sin_y = _sin_amp_y * sin((_sin_per_y * pi * (sin_tick + (i*2)) / 150));
		var _curr_char = string_char_at(curr_drawn_text_t, i + 1);
	
		if (Game.dt > 0) {
			_shk_x = irandom(_sh_mag);
			_shk_y = irandom(_sh_mag);
		}
		if is_real(_d_color)
			draw_set_color(_d_color);
		else
			draw_set_color(c_white);
		if (!is_real(_d_font))
			_d_font = Game.font;
	
		if (force_color_t) // Override color for top text if control code in game dialogue demands it
			draw_set_color(color_f_t);
	
		/*
		if (port_on_t) {
			if (curr_port_ind_t > PortInds.BLANK)
				draw_portraits(1, alt_port_mode);
		}*/
	
	
	
		// //draw_text(x + 51, y + 142, loaded_text);
	
		show_tbox_text(x + 52 + _d_xoff + (_shk_x * Game.dt) + _sin_x, y + 49 - _upperbox_offset + _d_yoff + (_shk_y * Game.dt) + _sin_y, _curr_char, _d_font);
	}

	draw_set_color(c_white);
	draw_set_font(n_font);	
	draw_set_halign(fa_right);

	draw_set_halign(fa_left);

	// Print the nametag, if applicable
	if (nametag_on) {
		var _len = string_length(curr_nametag);
		var _n_x_off = 0;
	
		// Draw the nametag, one letter at a time
	
		for (var _i = 1; _i <= _len; _i++) {
			var _this_n_char = string_char_at(curr_nametag, _i);
			show_tbox_text(x + 4 + tbox_shake_x + _n_x_off, y + 49 + 100 - 30+ 4 - tbox_shake_y, _this_n_char, Game.font, c_white);
			_n_x_off += (8 - ds_list_find_value(Game.fnt_width, ord(_this_n_char)));
		}
	}

	sin_tick += 1 * Game.dt;


}

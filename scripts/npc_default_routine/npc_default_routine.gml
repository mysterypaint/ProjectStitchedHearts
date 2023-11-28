function npc_default_routine() {
	switch(state) {
		default:
		case nstates.IDLE:
			if (blink_timer <= 3 && blink_timer > 0) {
				img_index = 1;
			} else if (blink_timer <= 0) {
				img_index = 0;
				blink_timer = irandom(blink_timer_val);
			} else {
				img_index = 0;
			}
			blink_timer -= 1 * Game.dt;
			break;
		case nstates.TALKING:
			if (instance_exists(Textbox)) {
				if (Textbox.line_time % talk_ani_speed == 0) {
					if (img_index == 0 && Textbox.curr_nametag == nametag && Textbox.nametag_on && Textbox.enable_voice && Textbox.color != 16629864) // 16629864 = narrator color, aka make_color_rgb(104, 192, 253)
						img_index = 2; // Open the mouth if this NPC should be speaking
					else
						img_index = 0;
				}
		
				if (Textbox.curr_line_char_count >= string_length(Textbox.curr_line)) {
					// Do the idle state's blink routine if we're at the end of the textbox.
					if (blink_timer <= 3 && blink_timer > 0) {
						img_index = 1;
					} else if (blink_timer <= 0) {
						img_index = 0;
						blink_timer = irandom(blink_timer_val);
					} else {
						img_index = 0;
					}
					blink_timer -= 1 * Game.dt;
				}
			} else
				state = nstates.IDLE;
			break;
	}


}

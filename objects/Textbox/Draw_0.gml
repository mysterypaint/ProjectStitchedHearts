/// @description Drawing routine
draw_set_color(c_black);
draw_rectangle(x, y + 135, x + 335, y + 195, false);

draw_sprite(curr_port, curr_port_index, x + 7, y + 142);


draw_set_color(c_white);
	
if (curr_loaded_line_count > 0 || curr_line_char_count > 0) {
	draw_textbox();
}
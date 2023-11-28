/// @description Draw to the screen globally
if (state == GameStates.ABOUT_SCREEN) {
	draw_set_font(Game.font);
	draw_set_halign(fa_center);
	draw_text(win_width/2, 0, "\n- Project Stitched Hearts Engine Demo -" +
			"\n\n\n\n\nPress Confirm to begin.");
	
	draw_set_color(make_color_rgb(152,25,34));
	draw_text(win_width/2, 4*8, "This is a secret project.\nPlease do not distribute it!");
	
	draw_set_halign(fa_left);
	draw_set_color(c_gray);
	draw_text(0, 6*16, "- Controls -\nArrow Keys/WASD - Move" +
			"\nZ / J - ???\nX / L - Run\nC / K - Confirm\nF7 / Alt+Enter - Change window size\nEsc - Quit the game");
	
	draw_set_color(c_white);
}
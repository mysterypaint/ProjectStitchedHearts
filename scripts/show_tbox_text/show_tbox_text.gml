/// @description Draws text to the screen
/// @param x
/// @param y
/// @param string
/// @param font
/// @param text_blend_color
function show_tbox_text() {

	var _x = argument[0];
	var _y = argument[1];
	var _chr = argument[2];
	var _in_fnt = argument[3];

	if (argument_count > 4)
		var _blend_color = argument[4];
	else
		var _blend_color = c_white;

	var _linebreak_count = 0;
	var _chr_height = string_height("C");
	var _x_off = 0;
	var _y_off = 0;
	var _chr_width = 0;
	var _curr_fnt_width_arr = Game.fnt_width;
	var _xskew = 0;
	var _spr_fnt = sprFont;

	var _spr_fnt_width = sprite_get_width(_spr_fnt);

	_chr_width = ds_list_find_value(_curr_fnt_width_arr, ord(_chr));
	var _img_index = ord(_chr) - 33;
	if (_img_index >= 0) {
		var _spr_uvs = sprite_get_uvs(_spr_fnt, _img_index);
		_x_off += _spr_uvs[4];
		_y_off += _spr_uvs[5];
		var _img_xscale = _spr_uvs[6];
		var _img_yscale = _spr_uvs[7];
		draw_sprite_skew_ext(_spr_fnt, _img_index, _x + _x_off, _y + _y_off, _img_xscale, _img_yscale, 0, _blend_color, 1, _xskew, 0);
	}

	/*
	for (var i = 1; i <= string_length(_chr); i++) {
		var _this_char = string_char_at(_chr, i);

		_chr_width = ds_list_find_value(_curr_fnt_width_arr, ord(_this_char));
		if (_this_char == "\n") {
			_x_off = 0;
			_chr_width = 0;
			_linebreak_count++;
			_y_off += _spr_fnt_width;
		}
		var _img_index = ord(_this_char) - 33;
	
		if (_img_index >= 0) {
			var _spr_uvs = sprite_get_uvs(_spr_fnt, _img_index);
			_x_off += _spr_uvs[4];
			_y_off += _spr_uvs[5];
			var _img_xscale = _spr_uvs[6];
			var _img_yscale = _spr_uvs[7];
			draw_sprite_skew_ext(_spr_fnt, _img_index, _x + _x_off, _y + _y_off, _img_xscale, _img_yscale, 0, _blend_color, 1, _xskew, 0);
		}
		//draw_text(_x + _x_off, _y + (_linebreak_count * _chr_height), _this_char);
	
		_x_off += _chr_width;
	}

/* end show_tbox_text */
}

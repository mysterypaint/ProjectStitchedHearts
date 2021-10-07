/// @description create_textbox
/// @param dialogue_label_index
/// @param line_to_read_from
/// @param parent_object_index
/// @param parent_object_id
function create_textbox() {

	// Argument0: The key to load from the Game.loaded_text and Game.loaded_text_line_count ds_maps.
	// Argument1: The line number to start reading from (relative to the dialogue's :: label)
	// Argument2: The object index of the instance this box was created from
	// Argument3: The id of the instance this box was created from

	if (instance_exists(Textbox))
		instance_destroy(Textbox);

	var _text = ds_map_find_value(TextData.loaded_text, argument[0]);
	var _line_count = ds_map_find_value(TextData.ltext_line_count, argument[0]);

	var _broke = false;
	if (argument[1] > _line_count || is_undefined(_line_count) || is_undefined(_text))
		_broke = true;

	var _the_textbox = instance_create_layer(view_wport[0], view_hport[0], "LayerUI", Textbox);
	with (_the_textbox) {
		loaded_text = _text;
		loaded_text_line_count = _line_count;
		if (!_broke) {
			curr_loaded_line_count = argument[1] - 1;
			lines_skipped = argument[1];
		
			if (argument_count > 2)
				parent_obj_index = argument[2];
			if (argument_count > 3)
				parent_id = argument[3];
		} else {
			broke = true;
			curr_loaded_line_count = 0;
			lines_skipped = 1;
		
			loaded_text[0] = "[/PORT][/V][NAME:Dev. Team][/COL][S:2]Congratulations!||||||||||||\nYou broke it!";
			loaded_text_line_count = 1;
		}
	}



}

/// @param text_file_name
/// @param line_to_start_reading_from
function load_text(argument0, argument1) {
	/*
	This script loads the specified txt and starts storing its contents in a ds_list
	(Game.loaded_text), which is then passed to a new Textbox with the same variable name (loaded_text)

	argument0: filename of txt, as a string, to load (include the file extension)
	argument1: the line we should start reading the txt from (first line is "1")

	*/
	if instance_exists(TextData)
		with (TextData)
			instance_destroy();

	with (Game) {
	
		var _skip_lines = argument1 - 1;
		var _broke = false;	// Flag that overwrites the dialogue with debug text

		var _f_name = working_directory + "Dialogue/" + argument0;

		if (argument1 <= 0) {
			_skip_lines = 0;
			lines_skipped = 1;
		}
	
		var _tdata_obj = instance_create_layer(x, y, "LayerInstances", TextData);
	
		var _loaded_text_line_count = 0; // Count the lines per dialogue sector within the .txt, broken by "^^^"; Store all the values of every dialogue in Game's loaded_text_line_count ds_list.

		if file_exists(_f_name) {
			var _o_file = file_text_open_read(_f_name);
		
			while(_skip_lines > 0 && !file_text_eof(_o_file)) {
			  file_text_readln(_o_file); //Skip all irrelevant lines before we actually start reading the txt.
				_skip_lines--;
				_loaded_text_line_count++;
			}
	
			var _curr_dialog = "";
	
			var _file_line_count = 0;
			var _identifier = "";
	
			curr_line = file_text_readln(_o_file);

			while(true) { // While we're not at the end of the file yet...
				if (string_length(curr_line) > 1) {
					if (string_copy(curr_line, 0, 3) == ":: ") {
						// Add the temporary dialogue _curr_dialog to loaded_text
						_curr_dialog = "";
						_loaded_text_line_count = 0;
				
						// Define the new identifier
						_identifier = string_copy(curr_line, 4, string_length(curr_line)-5);
					} else {
						while(!file_text_eof(_o_file) && string_copy(curr_line, 0, 3) != ":: ") {
					
							if (string_length(curr_line) > 1 && !file_text_eof(_o_file)) {
								curr_line = string_copy(curr_line, 1, string_length(curr_line));
								curr_line = string_replace(curr_line, chr(13), "");				// Return
								curr_line = string_replace(curr_line, chr(0), "");				// Null
								curr_line = string_trim(curr_line, "both", chr(9));		// Tab Indent
								curr_line = string_trim(curr_line, "both", chr(32));	// Space
							}
						
							if (string_char_at(curr_line, 1) != "\r" && 
									string_length(curr_line) > 0 && 
									string_char_at(curr_line, 1) != chr(32)) { // If, after trimming, the current line isn't blank...
								_curr_dialog += curr_line;			// ... Amend the current line to our textbox data
								_loaded_text_line_count++;			// Variable from Game object for debugging where we are in the script (passed to Textbox when creating it)
							}
							curr_line = file_text_readln(_o_file);
						}
					
						if (file_text_eof(_o_file)) {
							_loaded_text_line_count++;
							ds_map_add(_tdata_obj.ltext_line_count, _identifier, _loaded_text_line_count);
							_loaded_text_line_count = 0;
						} else {
							ds_map_add(_tdata_obj.ltext_line_count, _identifier, _loaded_text_line_count);
							ds_map_add(_tdata_obj.loaded_text, _identifier, _curr_dialog);
							_curr_dialog = "";
						}
					
						
						if (string_copy(curr_line, 0, 3) == ":: ") {
							if (file_text_eof(_o_file)) {
								show_debug_message("Warning: Label defined at the end of the text doc with no content.");
								break; // Abort and ignore if we're about to define a label at the end of the text doc
							}
							// Add the temporary dialogue _curr_dialog to loaded_text
							_curr_dialog = "";
							_loaded_text_line_count = 0;
				
							// Define the new identifier
							_identifier = string_copy(curr_line, 4, string_length(curr_line)-5);
						} else if (file_text_eof(_o_file)) {
							_curr_dialog += curr_line;
							ds_map_add(_tdata_obj.loaded_text, _identifier, _curr_dialog);
							_loaded_text_line_count++;
							if (ds_map_size(_tdata_obj.ltext_line_count) > 1)
								ds_map_add(_tdata_obj.ltext_line_count, _identifier, _loaded_text_line_count);
							_loaded_text_line_count = 0;
							break;
						}
				
					}
				}
				curr_line = file_text_readln(_o_file);		
		
				_file_line_count++;
			}

			if (ds_map_size(_tdata_obj.loaded_text) <= 0)
				_broke = true;
			file_text_close(_o_file); // Close the open txt to prevent memory leaks
		} else _broke = true;
		// Add the temporary dialogue _curr_dialog to loaded_text

		if (_broke) { // If anything fails during file reading, clear the ds_list and print the debug message... then abort the script.
			ds_map_clear(_tdata_obj.loaded_text);
			ds_map_add(_tdata_obj.loaded_text, "broken", "[/PORT][/V][NAME:Dev. Team][/COL][S:0]Congratulations!||||||||||||#You broke it!");
			exit;
		}
	}



}

/// string_trim(string Inputstring, string _side="both", string _char=" ")
function string_trim() {
	// Description: Removes leading and trailing matches of a string.
	// --- Arguments ---
	// Inputstring - the input to trim
	// (optional) _side - "left", "right", or "both". Uses "both" when empty.
	// (optional) _char - the character to remove. Uses the " " character (space) when empty
	/// Original script by Remixful

	var _str = string(argument[0]);
	var _side = "both";
	var _char = " ";
	if argument_count >= 2 {
		if (argument[1] == "left" or argument[1] == "right" or argument[1] == "both")
			_side = argument[1];
	}
	if (argument_count == 3)
		_char = string(argument[2]);
	var new_string = _str;
	if _side == "left" or _side == "both" {
		var _start = 0;
		for(var i = 1; i <= string_length(new_string); i++) {
			if (string_char_at(new_string, i) != _char) {
				_start = i - 1;
				break;
			}
		}
		if (_start != 0)
			new_string = string_delete(new_string, 1, _start);
	}
	if (_side == "right" or _side == "both") {
		var _end = 0;
		for(var i = string_length(new_string); i > 0; i--) {
			if (string_char_at(new_string, i) != _char) {
				_end = i + 1;
				break;
			}
		}
		if (_end != 0)
			new_string = string_delete(new_string, _end, string_length(new_string));
	}
	return new_string;



}

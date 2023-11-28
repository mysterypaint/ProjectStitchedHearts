/// @description Hide room layers whenever a room starts, besides the Background and UI Layers
var _layers = layer_get_all();
var _len = array_length_1d(_layers);
for (var i = 0; i < _len; i++;) {
	var _this_layer = _layers[i];
	var _name = layer_get_name(_this_layer);
	if (_name != "LayerBackground" && _name != "LayerUI") {
		layer_set_visible(_this_layer, false);
	}
}
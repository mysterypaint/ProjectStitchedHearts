function draw_tilemap_layer(argument0) {
	var _lay_id = layer_get_id(argument0);
	var _map_id = layer_tilemap_get_id(_lay_id);
	if (layer_tilemap_exists(_lay_id, _map_id)) {
	    draw_tilemap(_map_id,0,0);
	}


}

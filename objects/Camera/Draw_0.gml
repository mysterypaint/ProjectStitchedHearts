/// @description Draw routine

draw_tilemap_layer("TileLayer1");

draw_entities_with_depth();

draw_tilemap_layer("TileLayerOver");

// Draw the shadow layer

if surface_exists(surf) {
	var _shadow_lay_id = layer_get_id("TileLayerShadows");
	var _shadow_map_id = layer_tilemap_get_id(_shadow_lay_id);
    if (layer_tilemap_exists(_shadow_lay_id, _shadow_map_id)) {
        surface_set_target(surf);
        //draw_tilemap(_shadow_map_id,0,0);
        surface_reset_target();
        //layer_tilemap_destroy(_shadow_map_id);
    }

   // draw_surface_ext(surf, 0, 0, 1, 1, 0, c_red, 0.5);

} else {
    surf = surface_create(room_width,room_height);
    surface_set_target(surf);
    draw_clear_alpha(c_black, 0);   
    surface_reset_target();
}
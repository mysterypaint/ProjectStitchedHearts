/// @description Stretch the hitbox all the way to the end of the room
event_inherited();
var _tile_fill = (x / sprite_width);

x += sprite_width;

image_xscale = -_tile_fill - 2;
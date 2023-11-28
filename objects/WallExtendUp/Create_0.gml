/// @description Stretch the hitbox all the way to the end of the room
event_inherited();
var _tile_fill = (y / sprite_height);

y += sprite_height;

image_yscale = -_tile_fill - 2;
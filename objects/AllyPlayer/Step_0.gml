/// @description Movement code
event_inherited();

x = Player.trail_buffer_x[position_lag];
y = Player.trail_buffer_y[position_lag];
img_index = Player.img_index_buffer[position_lag];
img_index_offset = Player.img_index_offset_buffer[position_lag];

if (Player.state == PStates.IDLE)
	img_index = 1;

img_index += img_speed;
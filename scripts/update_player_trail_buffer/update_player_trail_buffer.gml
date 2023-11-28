function update_player_trail_buffer() {
	// Update the player's trail buffer
	for (var i = ally_trail_buffer - 1; i > 0; i--) {
		trail_buffer_x[i] = trail_buffer_x[i-1];
		trail_buffer_y[i] = trail_buffer_y[i-1];
		img_index_buffer[i] = img_index_buffer[i-1];
		img_index_offset_buffer[i] = img_index_offset_buffer[i-1];
	}
	
	// Store the player's current position at the front of the array
	trail_buffer_x[0] = x;
	trail_buffer_y[0] = y;
	img_index_buffer[0] = img_index;
	img_index_offset_buffer[0] = img_index_offset;


}

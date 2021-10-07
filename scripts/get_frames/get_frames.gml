/// @function get_frames
/// @description Takes the number of seconds as input and returns the time in number of frames (which is dependent on the room speed)
/// @param seconds
function get_frames(argument0) {
	var _seconds = argument0;
	return round(room_speed * _seconds);


}

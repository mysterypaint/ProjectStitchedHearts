function sfx_play(argument0, argument1, argument2) {
	var _sound_id = argument0;
	var _priority = argument1;
	var _loops = argument2;

	audio_stop_sound(_sound_id);
	audio_play_sound(_sound_id, _priority, _loops);


}

/// @description Player logic
event_inherited();

switch (state) {
	case PStates.IDLE:
		player_movement_code();
		break;
	case PStates.MOVING:
		player_movement_code();
		break;
}

if (!instance_exists(Textbox))
	if (Game.pressed_key_confirm)
		create_textbox("Test1", 1, object_index, id); // Read from message1/message2/message3/message4 if this NPC isn't affected by cutscenes // instance_create_depth(Camera.x, Camera.y, -1, Textbox);

img_index += img_speed;
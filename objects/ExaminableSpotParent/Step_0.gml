/// @description Basic examinable interaction

// Inherit the parent event
event_inherited();

depth = y;

if (instance_exists(PauseMenuController) || Game.state = GameStates.PAUSED)
	exit;

switch(behavior) {
	case "standing":
	default:
		npc_default_routine();
		break;
}

/*
	if (cs_destroy) {
		if (!SaveController.seen_cutscenes[? cs_destroy_id]) { // Kill this NPC if the cutscene trigger has been met
			tl_execute(cutscene, 1);
			instance_destroy();
		}
	}
*/

var _inst = collision_line(bbox_left - hbox_pad, bbox_top - hbox_pad, bbox_right + hbox_pad, bbox_bottom + hbox_pad, Player, false, true);
if (_inst != noone) {
	if (Game.pressed_key_confirm && !instance_exists(Textbox) && Player.talk_buffer <= 0) {
		
		if (!dialog_swap) {
			create_textbox(dialog[times_talked], 1, object_index, id); // Read from message1/message2/message3/message4 if this NPC isn't affected by cutscenes
			if (times_talked < talk_max - 1)
				times_talked++;
		} else {
			if (!SaveController.seen_cutscenes[? dialog_swap_id]) {
				create_textbox(dialog_alt[times_talked], 1, object_index, id); // Read from messages a-d if we saw a specified cutscene
				if (times_talked < talk_alt_max - 1)
					times_talked++;
			} else {
				create_textbox(dialog[times_talked], 1, object_index, id); // Otherwise, read messages like usual.
				if (times_talked < talk_max - 1)
					times_talked++;
			}
		}
		state = nstates.TALKING;
		Player.talk_buffer = Player.talk_buffer_reset;
		
	}
}

if (instance_exists(Textbox)) {
	if (Textbox.parent_id == id) {
		if (can_turn) { // Look at the player if the player is talking to them, and the NPC allows it
			if (Player.x < x)
				facing = Facing.LEFT;
			else if (Player.x > x)
				facing = Facing.RIGHT;
		}
		
		var _facing = facing;
		switch(_facing) {
			case Facing.RIGHT:
				_facing = -1;
				break;
			default:
				_facing = 1;
		}
		
		img_xscale = _facing;
		
		if (!collision_circle(x, y, 400, Player, false, false))
			instance_destroy(Textbox); // Destroy the textbox this NPC said if the player walks too far away from them.
	}
}
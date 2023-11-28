/// @description Init vars
// Inherit the parent event
event_inherited();

enum nstates {
	IDLE,
	WALKING,
	TALKING,
	RUNNING
}

state = nstates.IDLE;

spr_index = sprPlayer;
times_talked = 0;
talk_ani_speed = 9;
talk_max = 1;
talk_alt_max = 0;
hbox_pad = 40;
dialog[0] = "you_broke_it";

dialog_alt[0] = "you_broke_it";
dialog_swap = false;
dialog_swap_id = "";
cs_destroy = false;
cs_destroy_id = "";

behavior = "standing";
nametag = "";
blink_timer_val = 250;
blink_timer = irandom(blink_timer_val);
facing = Facing.LEFT;
can_turn = true;
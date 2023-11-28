/// @description Init variables
event_inherited();

move_speed = 1.2; //4
move_step = 0;

moving = false;
hsp = 0;
vsp = 0;
knocked_back = false;

// Used during map transitions
player_x = x;
player_y = y;
lock_move_x = 0;
lock_move_y = 0;
//init_slopes();

image_speed = 0.5;

enum FacingDir {
    LEFT,
    RIGHT,
    UP,
    DOWN,
    NULL
}






spr_index = sprPlayer;
img_index = 1;
img_index_offset = 0;
img_ani_max = 4;
img_speed = 0;

player_facing = Facing.DOWN;

enum PStates {
	IDLE,
	MOVING,
	CUTSCENE
}

state = PStates.IDLE;

ally_trail_buffer = 64;

for(var i = ally_trail_buffer - 1; i >= 0; i--){
    trail_buffer_x[i] = x;
    trail_buffer_y[i] = y;
	img_index_buffer[i] = img_index;
	img_index_offset_buffer[i] = img_index_offset;
}

// NPC Interaction
talk_buffer = 0;
talk_buffer_reset = 15;

ally_player = instance_create_depth(x, y, depth - 1, AllyPlayer);
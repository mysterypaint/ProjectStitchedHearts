/// @description Initialize variables
event_inherited();
position_lag = 16;

move_speed = 1.2;

hsp = 0;
vsp = 0;

spr_index = sprAllyPlayer;
img_index = 1;
img_index_offset = 0;
img_ani_max = 4;
img_speed = 0;
state = PStates.IDLE;
player_facing = Facing.DOWN;

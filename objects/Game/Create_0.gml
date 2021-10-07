/// @description Init variables
debug = false;
state = GameStates.INIT;
prev_state = GameStates.INIT;
window_size = 2;
win_width = 320;
win_height = 180;

dt = 1; // Delta time
ticks = 0; // How many ticks the game has been running for


// Textbox stuff
font = font_add_sprite(sprFont, ord("!"), true, 1);
fnt_width = ds_create("fnt_width", DS.LIST);
//fnt_width = ds_map_create();
define_font_widths();
log = "";

cam_obj = noone;

// Controller input
key_up = vk_up;
key_down = vk_down;
key_left = vk_left;
key_right = vk_right;
key_cancel = ord("Z");
key_confirm = ord("X");

key_up_alt = ord("W");
key_down_alt = ord("S");
key_left_alt = ord("A");
key_right_alt = ord("D");
key_cancel_alt = ord("J");
key_confirm_alt = ord("K");

/// @description Init vars
loaded_text = "";

curr_port = sprPortProtag;
curr_port_index = 0;



/// Initialize some variables
parent_id = noone;
parent_obj_index = noone; // The object index of the origin of this textbox (so we can tell if it came from an NPC/Sign or not)
depth = -10001;
image_speed = 0.15; // Only spr_textbox_continue relies on this
font = Game.font;
n_font = Game.font;

line_time = 0; // How long we've been reading this current line/message box for. (So we can control mouth movement)

image_speed = 0.15; // Only spr_textbox_continue relies on this
font = 0;
end_early = false; // Cuts off the dialogue as if it were the last line.
cutscene = false; // Flag marking whether or not the player should be allowed to move throughout this dialogue.
moving_cutscene = false; // Flag marking whether or not the textbox should hop up/down based on player's position (Bottom Textbox should be the only active textbox)

bottom = true; // Update the text on the lower textbox. Otherwise, update the text on the upper textbox
enable_voice = false; // Allows NPC talking sound to play per character
subtext_mode = false; // Alternate mode of drawing text for visual effect

//Animation stuff
alt_port_mode = false; // Use PropNPCPortLeft and PropNPCPortRight instead of the square portraits

blink_wait_timer_bottom = get_frames(0.5 + random(3.5));
blink_wait_timer_top = get_frames(0.5 + random(3.5));
eye_frame_index_bottom = 0;
eye_frame_index_top = 0;
mouth_frame_index_bottom = 0;
mouth_frame_index_top = 0;

eye_frames_bottom[0] = 0;
eye_frames_bottom[1] = 1;
eye_frames_bottom[2] = 2;
eye_frames_bottom[3] = 3;
eye_frames_top[0] = 0;
eye_frames_top[1] = 1;
eye_frames_top[2] = 2;
eye_frames_top[3] = 3;

mouth_frames_bottom[0] = 0;
mouth_frames_bottom[1] = 1;
mouth_frames_bottom[2] = 2;
mouth_frames_bottom[3] = 3;
mouth_frames_top[0] = 0;
mouth_frames_top[1] = 1;
mouth_frames_top[2] = 2;
mouth_frames_top[3] = 3;
init_portraits(); // Creates a ton of arrays that portraits refer to when drawn
curr_port_ind = PortInds.BLANK;
curr_port_ind_t = PortInds.BLANK;
continueBottomIndex = 0; // sprTextboxContinue animation for bottom textbox
continueTopIndex = 0; // sprTextboxContinue animation for top textbox
terminate = false; // Abort or conclude the textbox


loaded_text_line_count = 0;			// Used for debugging where we are in the script (passed from Game upon creation)
lines_skipped = 0;							// Used for debugging where we are in the script (passed from Game upon creation)

curr_drawn_text_b = ""; // The actual text to show up on the screen (bottom)
curr_drawn_text_t = ""; // The actual text to show up on the screen (top)
linebreak_count = 0;
curr_loaded_line_count = 0;
curr_line_dchar_count = 0; // Current number of characters in the currently drawing line.
curr_line_char_count = 0; // Current number of characters we've read on the given segment of dialogue.
curr_line = ""; // The current line the parser is reading.
edited_line = ""; // Whenever curr_line has been edited in amend_dialogue(), display this text instead

loaded_text = ""; // This contains all the text we loaded from the .txt. Passed from Game (or wherever you want to do it)
broke = false; // Show debug text if the game fails to load the correct text

// These are passed to the parallel arrays below as the text is being read, character by character
monospace = false; // false = enable VWF instead
color = c_white; // Text color
x_offset = 0;
y_offset = 0;
curr_font = Game.font;
curr_max_width = 6; // Font max dimensions are 6x12 by default.
curr_max_height = 12;//string_height("A");
shake_magnitude = 0; // For shaky text (0 = don't move at all)
sin_tick = 0; // Ticker so we can freeze the shakey text in place during pausing

// Parallel arrays for loaded_text to store data for every character for drawing
char_font = ds_create("char_font", DS.LIST);
char_max_width = ds_create("char_max_width", DS.LIST);
char_max_height = ds_create("char_max_height", DS.LIST);
char_color = ds_create("char_color", DS.LIST);
char_x_offset = ds_create("char_x_offset", DS.LIST);
char_y_offset = ds_create("char_y_offset", DS.LIST);
char_shake_magnitude = ds_create("char_shake_magnitude", DS.LIST);
char_shake_x = ds_create("char_shake_x", DS.LIST);
char_shake_y = ds_create("char_shake_y", DS.LIST);
char_sine_x = ds_create("char_sine_x", DS.LIST);
char_sine_y = ds_create("char_sine_y", DS.LIST);
char_sine_amp_x = ds_create("char_sine_amp_x", DS.LIST);
char_sine_amp_y = ds_create("char_sine_amp_y", DS.LIST);
char_sine_per_x = ds_create("char_sine_per_x", DS.LIST);
char_sine_per_y = ds_create("char_sine_per_y", DS.LIST);

tbox_sine_amp_x = 0;
tbox_sine_amp_y = 0;
tbox_sine_per_x = 0;
tbox_sine_per_y = 0;
tbox_shake_x = 0;
tbox_shake_y = 0;
tbox_shake_mag = 0;

end_early = false; // Flag that ends the dialogue (so we can abort a script within the script itself)
curr_spd = 2; // Higher = slower
curr_nametag = "???"; // Nametag to default to
curr_voice = "none"; // Sound to type characters with
curr_port_ind = PortInds.BLANK;
port_on = false;	// Hide/show the portrait box
nametag_on = false; // Hide/show the nametag box
max_len = 4; // Number of characters it can display per line (+2 leeway)
end_of_line = false; // Flag to know when to wait for the next action
advance = true; // Flag to continue the dialogue
continue_bottom = true; // Flag to prompt to continue the dialogue from the bottom or top textbox (bottom = true)
delay_timer = 0; // Counts down to when we're allowed to check the next character. Affected by speed, too.
new_line = true; // Flag to re-initiate the textbox every line.
can_control = true; // Flag to allow player to advance/speed up the dialogue
slide_in = false;
tbox_x_offset = 0;
tbox_y_offset = 128;

force_color_b = false;
color_f_b = c_white;  // Forced-color value to use for flag directly above this variable

//Upper textbox stuff
port_on_t = false;
curr_port_ind_t = PortInds.BLANK;
nametag_on_t = false;
curr_nametag_t = "???"; // Nametag to default to
color_t = c_white;
force_color_t = false;
color_f_t = c_white;  // Forced-color value to use for flag directly above this variable
slide_in_t = false;
tbox_x_offset_t = 0;
tbox_y_offset_t = -128;

char_font_t = ds_create("char_font_t", DS.LIST);
char_max_width_t = ds_create("char_max_width_t", DS.LIST);
char_max_height_t = ds_create("char_max_height_t", DS.LIST);
char_color_t = ds_create("char_color_t", DS.LIST);
char_x_offset_t = ds_create("char_x_offset_t", DS.LIST);
char_y_offset_t = ds_create("char_y_offset_t", DS.LIST);
char_shake_magnitude_t = ds_create("char_shake_magnitude_t", DS.LIST);
char_shake_x_t = ds_create("char_shake_x_t", DS.LIST);
char_shake_y_t = ds_create("char_shake_y_t", DS.LIST);
char_sine_x_t = ds_create("char_sine_x_t", DS.LIST);
char_sine_y_t = ds_create("char_sine_y_t", DS.LIST);
char_sine_amp_x_t = ds_create("char_sine_amp_x_t", DS.LIST);
char_sine_amp_y_t = ds_create("char_sine_amp_y_t", DS.LIST);
char_sine_per_x_t = ds_create("char_sine_per_x_t", DS.LIST);
char_sine_per_y_t = ds_create("char_sine_per_y_t", DS.LIST);


time_alive = 0;

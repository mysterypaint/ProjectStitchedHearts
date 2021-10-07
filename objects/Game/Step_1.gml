/// @description Determine key presses
pressed_key_confirm = keyboard_check_pressed(key_confirm) || keyboard_check_pressed(key_confirm_alt);
holding_key_cancel = keyboard_check(key_cancel) || keyboard_check(key_cancel_alt);
holding_key_left = keyboard_check(Game.key_left) || keyboard_check(Game.key_left_alt);
holding_key_right = keyboard_check(Game.key_right) || keyboard_check(Game.key_right_alt);
holding_key_up = keyboard_check(Game.key_up) || keyboard_check(Game.key_up_alt);
holding_key_down = keyboard_check(Game.key_down) || keyboard_check(Game.key_down_alt);
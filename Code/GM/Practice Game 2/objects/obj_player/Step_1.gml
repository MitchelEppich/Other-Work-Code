/// @description Movement setup
// Stop vertical movement if grounded
if grounded vspeed = 0;

// Stop horizontal movement if colliding with wall
if wall_collision hspeed = 0;

// Movement keys
key_forward = keyboard_check(ord("D")) || keyboard_check(vk_right);
key_backward = keyboard_check(ord("A")) || keyboard_check(vk_left);

// Select item from inventory
if keyboard_check_pressed(ord("Z")) && keyboard_check_pressed(ord("X")) 
{
	inv_index = real(get_string("Inventory Index Value :", "0"));
}

// Faint if time passes a certain time
if global.time > global.nightTime && global.time < global.morningTime scr_faint();
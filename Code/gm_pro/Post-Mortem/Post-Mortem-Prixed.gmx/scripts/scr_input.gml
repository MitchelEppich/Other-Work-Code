/// scr_key_inputs(value)

// -- Do not touch -- //

/*
    key --> keyboard
    ms --> mouse
    gp --> gamepad
    alt --> alternative
*/

global.key = ds_map_create();

global.key[? "c_right"] = keyboard_check_pressed(vk_right);
global.key[? "c_left"] = keyboard_check_pressed(vk_left);
global.key[? "c_up"] = keyboard_check_pressed(vk_up);
global.key[? "c_down"] = keyboard_check_pressed(vk_down);

global.key[? "right"] = keyboard_check(vk_right);
global.key[? "left"] = keyboard_check(vk_left);
global.key[? "up"] = keyboard_check(vk_up);
global.key[? "down"] = keyboard_check(vk_down);

global.key[? "enter"] = keyboard_check_pressed(vk_enter);
global.key[? "back"] = keyboard_check_pressed(ord('B'));
global.key[? "mute"] = keyboard_check_pressed(ord('M'));

global.key[? "space"] = keyboard_check_pressed(vk_space);
global.key[? "spec"] = keyboard_check(ord('A'));
global.key[? "interact"] = keyboard_check_pressed(ord('Z'));
global.key[? "attack"] = keyboard_check_pressed(ord('X'));

global.key[? "scroll_up"] = mouse_wheel_up();
global.key[? "scroll_down"] = mouse_wheel_down();

global.key[? "m_left"] = mouse_check_button(mb_left);
global.key[? "m_right"] = mouse_check_button(mb_right);

global.key[? "exit"] = keyboard_check_pressed(vk_escape);
global.key[? "reset"] = keyboard_check_pressed(ord('P'));

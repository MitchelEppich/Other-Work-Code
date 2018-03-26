/// scr_key_inputs(value)

// -- Do not touch -- //

/*
    key --> keyboard
    ms --> mouse
    gp --> gamepad
    alt --> alternative
*/

// Identifier
    var user = argument0;

// Navigation

    // Keyboard
    
        // Up
        key_up = keyboard_check(vk_up) || 
        keyboard_check(ord("W")) ||
        gamepad_button_check(user, gp_axislv) ||
        gamepad_button_check(user, gp_axisrv)
        
        // Down
        key_down = keyboard_check(vk_down) || 
        keyboard_check(ord("S")) ||
        gamepad_button_check(user, gp_axislv) ||
        gamepad_button_check(user, gp_axisrv)
        
        // Left
        key_left = keyboard_check(vk_left) || 
        keyboard_check(ord("A")) ||
        gamepad_button_check(user, gp_axislh) ||
        gamepad_button_check(user, gp_axisrh);
        
        // Right
        key_right = keyboard_check(vk_right) || 
        keyboard_check(ord("D")) ||
        gamepad_button_check(user, gp_axislh) ||
        gamepad_button_check(user, gp_axisrh);

// Actions
    
    // Keyboard
    
        key_space = keyboard_check(vk_space) ||
        gamepad_button_check(user, gp_face1);
        
        key_enter = keyboard_check_pressed(vk_enter) ||
        gamepad_button_check(user, gp_face1);
        
        key_interact = keyboard_check(vk_rshift) || 
        keyboard_check(ord("Z")) || 
        gamepad_button_check(user, gp_face2) || 
        gamepad_button_check(user, gp_shoulderlb);
        
        key_modify = keyboard_check(vk_alt) || 
        keyboard_check(ord("X")) ||
        gamepad_button_check(user, gp_face3) || 
        gamepad_button_check(user, gp_shoulderrb);
        
        key_scroll_up = keyboard_check(vk_shift) && keyboard_check(vk_up) ||
        gamepad_button_check(user, gp_padu) ||
        mouse_wheel_up() ||
        gamepad_button_check(user, gp_shoulderr);
        
        key_scroll_down = keyboard_check(vk_shift) && keyboard_check(vk_down) ||
        gamepad_button_check(user, gp_padd) ||
        mouse_wheel_down() ||
        gamepad_button_check(user, gp_shoulderl);
    
    // Mouse
    
        ms_left = mouse_check_button(mb_left);
        ms_right = mouse_check_button(mb_right);
    
// Development

    // Keyboard
    
        key_console = keyboard_check(vk_lshift) && keyboard_check(ord("1"));
        key_terminate = keyboard_check(vk_lshift) && keyboard_check(ord("0"));
        key_detach = keyboard_check(vk_lshift) && keyboard_check(ord("3"));
        key_attach = keyboard_check(vk_lshift) && keyboard_check(ord("2"));
        key_debug = keyboard_check(vk_lshift) && keyboard_check(ord("4"));
        key_any = keyboard_check(vk_anykey);

// Control
    
    // Keyboard
    
        key_quit = keyboard_check(vk_escape);
        
        key_menu = keyboard_check(vk_shift) && keyboard_check(ord("M")) ||
        gamepad_button_check(user, gp_start);
        
        key_pause = keyboard_check(ord("P")) || 
        gamepad_button_check(user, gp_select);
        
        key_zoomin = keyboard_check(ord("O"));
        key_zoomout = keyboard_check(ord("P"));
        
        key_mute = keyboard_check(ord("M"));

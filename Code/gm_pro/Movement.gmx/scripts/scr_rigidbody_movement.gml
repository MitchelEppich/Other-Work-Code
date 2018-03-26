/// scr_rigidbody_movement ( controlled )
if (argument0)
    scr_movement(keyboard_check(vk_right), keyboard_check(vk_left),
        keyboard_check(vk_up), keyboard_check(vk_down),
        keyboard_check(vk_space));
else
    movement_wrapper();
    
display_health();
//scr_plat_horizontal(vk_right, vk_left, vk_space);
//scr_plat_vertical(vk_up, vk_down);
//scr_apply_friction();

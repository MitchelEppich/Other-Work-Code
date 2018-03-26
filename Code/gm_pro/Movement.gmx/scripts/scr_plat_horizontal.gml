/// scr_plat_horizontal( key_right, key_left, key_dash )  
c_dir = keyboard_check(argument0) - keyboard_check(argument1);

c_baseSpeed = c_speed + (keyboard_check(argument2) * c_boostSpeed);

dx = c_acceleration;

if (hspeed > c_baseSpeed)
    c_baseSpeed = hspeed;

if (c_dir != 0)
    hspeed = scr_lerp(hspeed, c_baseSpeed * c_dir, dx);

/// scr_fire_projectile ( projectile, acc_speed, max_speed )
if (mouse_check_button(mb_left))
    if (c_projectileSpeed < argument2)
        c_projectileSpeed += argument1;

if (mouse_check_button_released(mb_left))
{
    c_projectile = instance_create(x, y, obj_projectile);
    c_projectile.c_speed = c_projectileSpeed;
    c_projectile.c_angle = point_direction(x,y,mouse_x,mouse_y);
    c_projectile.c_creator = c_id;
    with c_projectile angular_speed_correction();
    
    c_projectileSpeed = 0;
}

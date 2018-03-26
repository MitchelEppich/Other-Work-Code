/// scr_simple_object ( )
if (c_locked)
    exit;

if (!collision_detected(x + dx, y + dy) && !c_locked)
{
    if (c_locked) print("fuck");
    // Move Horitzontal
    if (c_grounded)
        dx = scr_lerp(dx, 0, c_friction);
    else
        dx = scr_lerp(dx, 0, c_airFriction);
     
    // Move Vertical
    if (!c_grounded)
    {
        dy = scr_lerp(dy, inf, c_gravity);
    }
    c_grounded = collision_detected(x, y + abs(dy));
    
    // Modify Speed
    if (c_grounded)
        c_speed = scr_lerp(c_speed, 0, c_friction);
    else
        c_speed = scr_lerp(c_speed, 0, c_airFriction);
        
    if (collision_detected(x + dx, y))
        dx *= -c_elasticity;
        
    if (collision_detected(x, y + dy))
        dy *= -c_elasticity;
    
    image_angle = interpret_angle();
    
    // Apply Move
    move(dx, dy, 0);
    
    if (collision_detected(x + dx + dx, y + dy + dy ))
        move(dx * 2, dy * 2, 1);
} 

/// scr_movement ( key_right, key_left, key_up, key_down, key_boost)

if(c_locked)
    exit;

// Move Horitzontal
c_dir = argument0 - argument1;

c_baseSpeed = c_speed + (argument4 * c_boostSpeed);

if (c_dir != 0)
    if (c_grounded)
        dx = scr_lerp(dx, c_baseSpeed * c_dir, c_acceleration * (1 - c_drag));
    else
        dx = scr_lerp(dx, c_baseSpeed * c_dir, c_acceleration * (1 - c_airDrag));
else
    if (c_grounded)
        dx = scr_lerp(dx, 0, c_friction);
    else
        dx = scr_lerp(dx, 0, c_airFriction);
 
// Move Vertical
if (argument2 && c_grounded)
    dy = -c_jumpSpeed;
else if (!c_grounded && collision_detected(x + dx, y) && !collision_detected(x, y + sprite_height))
{
    if (argument2)
    {
        dy = -c_jumpSpeed;
        dx = c_reboundSpeed * -c_dir;
    }
    else
        dy = scr_lerp(dy, c_edgeSpeed, c_gravity - c_friction);
}
else if (!c_grounded)
    dy = scr_lerp(dy, inf, c_gravity);
    
if (!argument2 && c_grounded)
    dy = c_reboundSpeed;
    
c_grounded = collision_detected(x, y + dy);
argument3 = argument3;
// Apply Move
move(dx, dy, 0);
update_children(dx, dy, id);

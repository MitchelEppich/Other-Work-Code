/// move ( x, y, exception )
if (c_locked)
    exit;
    
if (abs(argument0) > 0.5)
    if (!collision_detected(x + argument0, y) || argument2)
        x = x + argument0;
    else
        move(argument0 * 0.90, 0, 0)
    
if (abs(argument1) > 0.5)
    if (!collision_detected(x, y + argument1) || argument2)    
        y = y + argument1;
    else
        move(0, argument1 * 0.90, 0)

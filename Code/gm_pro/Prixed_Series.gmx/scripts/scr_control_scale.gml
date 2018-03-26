/// scr_control_scale()
scaling = !grounded and (l_wall or r_wall);

if (l_wall)
{
    x_scale = -abs(x_scale);
} else if (r_wall) {
    x_scale = abs(x_scale);
} 

var _height = 4;

// Wall Sliding ////////////////////////////////
if (_edge_scale) vsp = -obj_physics.grav*2;
//var h = !position_meeting(x + hsp, y + 4, obj_solid) and position_meeting(x + hsp, y, obj_solid);

//if h != 0 show_debug_message(string(h));

if((l_wall or r_wall) and !grounded and vsp >= 0.5)
{
    
    if ((place_free(x + 1, y - _height) and r_wall) or (place_free(x - 1, y - _height) and l_wall))
    {
        _edge_scale = true;
    } else {
        vsp -= obj_physics.grav*0.5; // Negate half of gravity
    }
} else {
    _edge_scale = false;
}

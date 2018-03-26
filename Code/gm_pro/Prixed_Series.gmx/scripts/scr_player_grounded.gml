/// scr_player_grounded()

if(place_meeting(x, y+1, obj_solid))
{
    return true;
}
else if(jump_hold)
{
    vsp += obj_physics.grav*0.5; // Half Gravity
    return false;
}
else
{
    vsp += obj_physics.grav; // Gravity
    return false;
}

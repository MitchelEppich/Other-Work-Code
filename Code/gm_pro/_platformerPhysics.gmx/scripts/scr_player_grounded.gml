// scr_player_grounded()

if(place_meeting(x, y+1, oSolid))
{
    return true;
}
else if(jump_hold)
{
    vsp += oPhysics.grav*0.5; // Half Gravity
    return false;
}
else
{
    vsp += oPhysics.grav; // Gravity
    return false;
}

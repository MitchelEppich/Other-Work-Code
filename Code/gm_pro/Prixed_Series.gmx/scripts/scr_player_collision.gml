/// scr_player_collision()

// Moving Horizontally /////////////////////////////
if(place_meeting(x+hsp, y, obj_solid))
{
    while(!place_meeting(x+sign(hsp), y, obj_solid)){ x += sign(hsp) };
    hsp = 0;
}

// Apply speed after checks ////////////////////////
x += hsp;

// Moving Vertically ///////////////////////////////
if(place_meeting(x, y+vsp, obj_solid))
{
    while(!place_meeting(x, y+(sign(vsp)/10), obj_solid)){ y += (sign(vsp)/10) };
    
    if(place_meeting(x, y+1, obj_solid))// Squish when landing
    {
        grounded = true;
        
        //x_scale = 1.25;
        //y_scale = 0.75;
    }
    
    if(place_meeting(x, y+1, obj_solid) and vsp > 5.0)// Shake when landing
    {
        grounded = true;
        
        //x_scale = 1.0+(vsp/10);
        //y_scale = 1.0-(vsp/10);
        
        if (vsp > 10.0)
        {
            alarm[1] = 60;
            stunned = true;
        }

        if (object_get_name(object_index) == "obj_player") scr_shake_screen(15, vsp/2.5);
    }
    
    vsp = 0;
    
}

// Apply speed after checks ////////////////////////////
y += vsp;


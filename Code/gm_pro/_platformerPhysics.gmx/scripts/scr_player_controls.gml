/// scr_player_controls()

// Set Variables //////////////////////////////

if(!grounded)// If we're in the air
{
    var acc = air_acc;
    var spd = air_max;
    var fric = air_fric;
}
else // If we're on the ground
{
    var acc = grnd_acc;
    var spd = grnd_max;
    var fric = oPhysics.fric;
}

var l_wall = place_meeting(x-1, y, oSolid);// Wall on left?
var r_wall = place_meeting(x+1, y, oSolid);// Wall on right?

// Get Key Input /////////////////////////////

key_w = keyboard_check(ord('W'));
key_a = keyboard_check(ord('A'));
key_s = keyboard_check(ord('S'));
key_d = keyboard_check(ord('D'));

key_spc = keyboard_check_pressed(vk_space);
key_spcr = keyboard_check_released(vk_space);

// Movement //////////////////////////////////

if(key_a)
{
    hsp -= acc;
    if(hsp > 0.3){ hsp -= fric };
}

if(key_d)
{
    hsp += acc;
    if(hsp < -0.3){ hsp += fric };
}

if((!key_a and !key_d) or (key_a and key_d))
{
    if(hsp > 0.3){ hsp -= fric };
    else if(hsp < -0.3){ hsp += fric };
    else{ hsp = 0 };
}

if(hsp > spd){ hsp = spd };
if(hsp < -spd){ hsp = -spd};

// Jumping ///////////////////////////////////

if(key_spc and grounded)// Initial jump
{
    vsp = jump_spd; // Move up
    
    x_scale = 0.75;// Change scale
    y_scale = 1.25;
    
    alarm[0] = 20;
    jump_hold = true;
}

if(key_spcr){ jump_hold = false };

// Wall Jumping //////////////////////////////

if(!grounded and (l_wall or r_wall))
{
    if(key_spc) // Jumping off wall
    {
        if(l_wall and key_a) // Towards left wall
        {
            hsp = jump_spd*-0.3;
            vsp = jump_spd*1.0;
        }
        else if(l_wall and !key_a)// Away left wall
        {
            hsp = jump_spd*-0.8;
            vsp = jump_spd*0.7;
        }
        else if(r_wall and key_d) // Towards right wall
        {
            hsp = jump_spd*0.3;
            vsp = jump_spd*1.0;
        }
        else if(r_wall and !key_d)// Away right wall
        {
            hsp = jump_spd*0.8;
            vsp = jump_spd*0.7;
        }
        
        x_scale = 0.75;// Adjust scale
        y_scale = 1.25;
    }
    
    
    alarm[0] = 20;
    jump_hold = true;
}

// Wall Sliding ////////////////////////////////

if((l_wall or r_wall) and !grounded and vsp >= 0.5)
{
    vsp -= oPhysics.grav*0.5; // Negate half of gravity
}



























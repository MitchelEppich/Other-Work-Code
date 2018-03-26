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
    var fric = obj_physics.fric;
}

var l_wall = place_meeting(x-1, y, obj_solid);// Wall on left?
var r_wall = place_meeting(x+1, y, obj_solid);// Wall on right?

// Ai tick
if (tick) tick = 0;
tick = min(tick + 0.01, 1);

// Get Key Input /////////////////////////////

key_spc = obj_player.y - y < -5 and (l_wall || r_wall) and tick
    or (l_wall || r_wall) and obj_player.x != x and tick;
key_spcr = tick > 0.5;

key_w = abs(obj_player.x - x) < 10 and abs(obj_player.y - y) < 10;
key_a = (obj_player.x - x < -1 and !_follow or obj_player.x - x < -follow_distance) and (obj_player.x != x or key_spc);
key_s = false//abs(oPlayer.x - x) > 10 and abs(oPlayer.x - x) < 50 and !key_w and oPlayer._health > 5;
key_d = (obj_player.x - x > 1 and !_follow or obj_player.x - x > follow_distance) and (obj_player.x != x or key_spc);

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

// Stealth
_stealth = key_s and grounded;

// Attack
if (key_w and grounded) 
{   
    if (key_d or key_a)
    {
        rolling = true;
    } else if (!attacking) {
        attacking = true;
        hsp = 0;
        vsp = 0;  
    } 
} 

// Scale
scaling = !grounded and place_meeting(x + hsp, y, obj_solid);

// Bounds for speed
if(hsp > spd){ hsp = spd };
if(hsp < -spd){ hsp = -spd};

// Jumping ///////////////////////////////////

if(key_spc and grounded)// Initial jump
{
    vsp = jump_spd; // Move up
    
    //x_scale = 0.75;// Change scale
    //y_scale = 1.25;
    
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
        
        //x_scale = 0.75;// Adjust scale
        //y_scale = 1.25;
    }
    
    
    alarm[0] = 20;
    jump_hold = true;
}

// Wall Sliding ////////////////////////////////

if((l_wall or r_wall) and !grounded and vsp >= 0.5)
{
    vsp -= obj_physics.grav*0.5; // Negate half of gravity
}




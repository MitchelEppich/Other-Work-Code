/// scr_control_attack(input, r_input, l_input)
var key = argument0;
var r_key = argument1;
var l_key = argument2;

if (key and grounded) 
{   
    if (r_key or l_key)
    {
        rolling = true;
    } else if (!attacking) {
        attacking = true;
        hsp = 0;
        vsp = 0;  
    } 
} else {
    rolling = false;
    attacking = false;
}

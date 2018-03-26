var current_state = -1;
var this = argument0;

if(hspeed != 0)
    if(hspeed > 0) this.image_xscale = 1 * this.scale;
    else if(hspeed < 0) this.image_xscale = -1 * this.scale;
    
if(this.hspeed == 0) current_state = anim_stand;
if(abs(this.hspeed) > global.base_walk_speed) current_state = anim_walk;
if(abs(this.hspeed) > global.base_run_speed) current_state = anim_run;

if(this.attack) current_state = scr_get_anim(this);

if(this.vspeed != 0) current_state = anim_fall;

if(!this.alive) current_state = anim_dead;

if(current_state != -1) {
    var start = anim_pin[current_state, 0];
    if(image_index >= (start + (anim_pin[current_state, 1] - 1)) ||
    image_index < (start)) {
        image_index = anim_pin[current_state, 0];
    } 
    if(hspeed != 0 || vspeed == 0) if(!attack) image_speed = 0.3;
    else if(vspeed != 0) image_speed = 0;
}
    

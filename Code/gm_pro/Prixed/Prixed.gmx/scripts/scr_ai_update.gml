var this = argument0;

var min_distance = (this.sprite_width / 2) + this.weapon_range;

var target = this.targeted;

var distance_from_x = 0;
var distance_from_y = 0;

if(target != noone) {
    distance_from_x = target.x - this.x;
    distance_from_y = target.y - this.y;
}

var exe = "";
if(target != noone) {
    if(abs(distance_from_x) < this.feild_of_view)
        if(abs(distance_from_x) > min_distance || (-1 * distance_from_y) > min_distance || this.dir != target.dir) {
            exe = "follow";
        } else exe = "";
    
    if(abs(distance_from_x) < this.weapon_range && abs(distance_from_y) < this.weapon_range) {
        exe = "attack";
    }   
    
    if(this.hit_points < (this.max_hit_points * 0.1)) {
        exe = "evade";
    }
} else exe = "";
//if(this.master.inCombat) exe = "protect";

//if(this.targeted != noone) target = this.targeted;
//else target = obj_player;

scr_ai_brain(this, exe);

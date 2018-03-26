var this = argument0;
var target = this.targeted;

var exe = argument1;

var min_distance = (this.sprite_width / 2) + this.weapon_range;

var frequency = 20;

var distance_from_x = 0;
var distance_from_y = 0;

if(target != noone) {
    distance_from_x = target.x - this.x;
    distance_from_y = target.y - this.y;
}
//show_debug_message(this.hit_points);

switch(exe) {

case "follow":
    if(abs(distance_from_x) > min_distance) {
        if(distance_from_x < 0 ) this.action = "move_left";
        else if(distance_from_x > 0 ) this.action = "move_right";
    } else if((-1 * distance_from_y) > min_distance) this.action = "jump";
      else if(this.y >= 430) this.action = "jump";
break;

case "attack":
    if(global.tick mod frequency == 0) { 
        if(this.action == "attack") this.action = "";
        else this.action = "attack";
    }

break;

case "protect":
    if(this.master.inCombat) this.targeted = this.master.targeted;
break;

case "evade":
    if(abs(distance_from_x) < 100) {
        if(distance_from_x < 0 ) this.action = "move_right";
        else if(distance_from_x > 0 ) this.action = "move_left";
    } else this.action = "";
break;

case "collect":
break;

case "give":
break;

case "search":
break;

case "chat":
break;

case "suicide":
break;

case "":
    if(global.tick mod 100 == 0)
        this.action = choose("", "move_left", "move_right");
break;

}

var this = argument0;
var spd = argument1;
var jump_height = argument2;

if (this.action == "move_right") this.hspeed += spd;
if (this.action == "move_left") this.hspeed -= spd;

if(this.vspeed == 0)
    if (this.action == "jump") {
        this.vspeed = -jump_height;
        this.action = "";
    }

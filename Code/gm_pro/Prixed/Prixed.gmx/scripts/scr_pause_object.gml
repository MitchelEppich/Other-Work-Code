var this = argument0;
var alarms = argument1;

this.hspeed = 0;
this.vspeed = 0;

image_speed = 0;

if(alarms != 0)
    for(i = 0; i < alarms; i++) {
        this.alarm[i] = this.alarm[i] + 1;
    }

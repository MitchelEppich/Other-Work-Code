var this = argument0;
var mass = argument1; //  in kilograms

var fric = this.fric * (global.base_mass / mass);
var air_fric = global.air_fric * (global.base_mass / mass);
var grav = global.grav * (global.base_mass / mass);

var spd = this.hspeed;
var modifier = 1;

if(spd != 0) modifier = (spd / abs(spd));

if(this.vspeed != 0) f = fric + air_fric;
else f = fric;

if(abs(this.hspeed) != 0 && f < abs(this.hspeed)) this.hspeed += ((modifier * -1) * f);
else this.hspeed = 0;

inst = instance_position(this.x, this.y, obj_solid);
if(inst != noone && abs(this.vspeed) != 0 && this.vspeed > 0) this.vspeed = 0;
else if(inst == noone) this.vspeed += grav;

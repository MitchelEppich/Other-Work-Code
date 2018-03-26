var this = argument0;

var inst = instance_place(this.x, this.y, obj_stealth);
if(inst != noone && !inst.refuel)
    if (this.action == "interact")
        if(inst.occupied == noone)
            inst.occupied = this;

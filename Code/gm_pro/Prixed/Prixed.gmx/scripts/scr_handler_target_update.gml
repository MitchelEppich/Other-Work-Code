var this = argument0;
var yy = this.y - (this.sprite_height / 4);
var inst = collision_line(this.x, yy, this.x + (this.weapon_range * this.dir), yy, obj_npc, false, true);

if(inst != noone && !inst.alive || inst != noone && inst.team == this.team)
    inst = noone;

return inst;

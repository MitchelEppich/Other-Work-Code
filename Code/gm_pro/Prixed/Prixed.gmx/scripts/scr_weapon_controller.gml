/// scr_weapon_controller(id, id, weapon_damage, weapon_range, spd, anim_death, depth, particle)
var this = argument0;
var whois = argument1;

whois.weapon_damage = argument2 * whois.level;
whois.weapon_range = argument3;

this.spd = argument4;

this.anim_death = argument5;
this.dir = whois.dir;

this.update_depth = argument7;
this.part = argument8;

var this = argument0;

if(!global.paused) {
hspeed = spd * dir;
image_xscale = dir;

scr_collectable_update(id, update_depth);
scr_part_update(part);

if(hspeed == 0) instance_destroy();
} else scr_pause_object(this, 1);

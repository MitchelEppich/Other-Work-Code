/// scr_animate_update(this, sprite_index, intial_frame, frames)
var this = argument0;
var sprite = argument1;
var animation_start = argument2;
var animation_end = argument3 - 1 + animation_start;

this.sprite_index = sprite;

if (this.image_index > animation_end || this.image_index < animation_start) 
    this.image_index = animation_start;

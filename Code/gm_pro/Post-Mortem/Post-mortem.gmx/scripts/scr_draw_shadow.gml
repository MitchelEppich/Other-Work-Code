///scr_draw_shadow(offset, correction)
var offset = argument0;
var correction = argument1;

var modifier = 2;
var correction_offset = 0;

if(correction != sprite_height/2)
    correction_offset = (correction * ((sprite_height / 2)/correction));

// Draw shadow and object
draw_sprite_ext(sprite_index, image_index, x, y+sprite_height - (offset*modifier) - correction_offset, image_xscale, -image_yscale/modifier, image_angle, c_black, 0.2);
draw_self();

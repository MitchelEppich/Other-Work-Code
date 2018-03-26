var this = argument0;

scr_display_speech(this);

image_alpha = this.alpha;
draw_sprite_ext(sprite_index, -1, x, y, image_xscale, image_yscale, image_angle, this.colour, this.alpha);


if(this.attack) {
    draw_sprite_ext(spr_human_weapon, -1, x, y, image_xscale, image_yscale, image_angle, -1, this.alpha);
}

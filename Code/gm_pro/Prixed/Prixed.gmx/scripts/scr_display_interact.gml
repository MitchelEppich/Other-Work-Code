var this = argument0;

draw_self();

scale = 2;

if(refuel) draw_sprite_ext(spr_symbols, 0, x, y - this.sprite_height / 2, scale, scale, 0, -1, 1);
else if(!occupied) draw_sprite_ext(spr_symbols, 1, x, y - this.sprite_height / 2, scale, scale, 0, -1, 1);
else draw_sprite_ext(spr_clock, count, x, y - this.sprite_height / 2, scale, scale, 0, -1, 1);

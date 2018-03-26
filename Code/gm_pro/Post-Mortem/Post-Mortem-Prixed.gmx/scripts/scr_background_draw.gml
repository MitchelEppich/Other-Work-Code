///scr_background_draw(id)
var this = argument0;

//Drawing Background for Gui
var size = 4;
draw_sprite_ext(spr_gui, 5, 10, 10, size, size, 0, -1, 1);
draw_sprite_ext(spr_gui, 6, 10, 10 + (16 * size), size, size, 0, -1, 1);
draw_sprite_ext(spr_gui, 2, 10 + (16 * size), 10 + (7 * size), size, size, 0, -1, 1);
draw_sprite_ext(spr_gui, 2, 10 + (16 * size * 2), 10 + (7 * size), size, size, 0, -1, 1);
draw_sprite_ext(spr_gui, 2, 10 + (16 * size * 3), 10 + (7 * size), size, size, 0, -1, 1);
draw_sprite_ext(spr_gui, 2, 10 + (16 * size * 4), 10 + (7 * size), size, size, 0, -1, 1);
draw_sprite_ext(spr_gui, 1, 10 + (16 * size * 5), 10 + (7 * size), size, size, 0, -1, 1);

for(i = 0; i < ceil(view_wport[0]/ (16 * 4)); i++) {
    draw_sprite_ext(spr_gui, 3, (16 * size) * i, 650, size, size, 0, -1, 1);
    draw_sprite_ext(spr_gui, 4, (16 * size) * i, 650 + (16 * size), size, size, 0, -1, 1);
}

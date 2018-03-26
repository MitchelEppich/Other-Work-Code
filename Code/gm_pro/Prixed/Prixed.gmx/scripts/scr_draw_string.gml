///scr_draw_string(x, y, string, scale, align, alpha, colour)
var xx = argument0;
var yy = argument1;
var str = argument2;
var scale = argument3;
var align = argument4;
var alpha = argument5;
var colour = argument6;

str = string_upper(str);

draw_set_halign(align);
draw_set_alpha(alpha);
draw_set_colour(colour);
draw_text_transformed(xx, yy, str, scale, scale, 0);

/*
for(i = 0; i < ds_list_size(letter); i++) {
    var num = ds_list_find_value(letter, i);
    draw_sprite_ext(spr, real(num), xx + ((sprite_get_width(spr)/2 + 5) * scale * i), yy, scale, scale, 0, colour, alpha);
}

var xx = argument0;
var yy = argument1;
var str = argument2;

var type = argument3;

var scale = argument4;

var name = argument5;

var align = fa_center;
var colour = -1;

var c = 0;
var m = ((string_length(str) * 4 * abs(scale)) /16);
if(type != 0) m = 1;
var xoffset = (m * 16 * abs(scale))/5;

var spr;
if(type != 0) spr = spr_button;
else spr = spr_gui;

var x1 = (xx -  xoffset/(abs(scale)+1)) - (sprite_get_width(spr) * abs(scale));
var x2 = x1 + sprite_get_width(spr) * abs(scale) * m;
var y1 = yy - ((sprite_get_width(spr)-4) * abs(scale) / 2);
var y2 = y1 + (sprite_get_width(spr) * abs(scale));

mx=window_mouse_get_x();
my=window_mouse_get_y();

//draw_rectangle_colour(x1, y1, x2, y2, c_red, -1, -1, -1, 0);

if(point_in_rectangle(mx, my, x1, y1, x2, y2)) {

    colour = -1;
    if(mouse_check_button_pressed(mb_left)) {
        scr_handler_button_update(name);
    }
} else colour = merge_colour(-1, c_black, 0.5);


if(type == 0) {
    for(i = 0; i < m; i++) {
        c = 2;
        if(i == 0) c = 0;
        if(i + 1 == m) c = 1;
        
        draw_sprite_ext(spr, c, xx - xoffset * 2 + (sprite_get_width(spr) * scale * i), yy - ((sprite_get_width(spr)-4) * scale / 2), scale, scale, 0, colour, 1);
    }
    
    scr_draw_string(xx + (xoffset/(scale)) - 15 + ((sprite_get_width(spr) * scale))/2, yy, str, scale, align, 1, colour);
} else draw_sprite_ext(spr, 0, xx - xoffset * 2, yy - (sprite_get_width(spr) * abs(scale) / 2), scale, abs(scale), 0, colour, 1);

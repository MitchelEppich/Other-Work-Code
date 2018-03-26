var scale = argument2;

var width = argument0;
var height = argument1;

var xx = 0;
var yy = 0;

var spr = spr_shop_screen;

var cx = argument3;
var cy = argument4;

for(var i = 0; i < width * height; i++) {
    var c;
        
        if(xx == 0) {
            if(yy == 0) c = 0;
            if(yy != 0) c = 3;
            if(yy == height - 1) c = 6;
        }
        if(xx != 0) {
            if(yy == 0) c = 1;
            if(yy != 0) c = 4;
            if(yy == height - 1) c = 7;
        }
        if(xx == width - 1) {
            if(yy == 0) c = 2;
            if(yy != 0) c = 5;
            if(yy == height - 1) c = 8;
        }
        
        draw_sprite_ext(spr, c, cx + (sprite_get_width(spr) * scale * xx), cy + (sprite_get_height(spr) * scale * yy), scale, scale, 0, -1, 1);
        
        if(xx >= width - 1) {
            yy++;
            xx = 0;
        } else xx++;
}

/// scr_check_covered(x, y)

var xx = argument0;
var yy = argument1;

var covered = collision_line(xx, yy, xx, 0, obj_tile_base, 0, 1);
return covered != noone;

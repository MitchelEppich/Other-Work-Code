var map = argument0;
var info = argument1;

var height = 0;
if(info == "height") {
    for(i = 0; i < ds_grid_height(map); i++) {
        if(is_real(ds_grid_get(map, 0, i))) break;
        height++;
    }
}

return height;

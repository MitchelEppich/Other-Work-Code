var map = argument0;
var value = argument1;

var pos = 0;

for(i = 0; i < ds_grid_height(map); i++) {
    if(string(ds_grid_get(map, 0, i)) == value) break;
    pos++;
}

return pos;

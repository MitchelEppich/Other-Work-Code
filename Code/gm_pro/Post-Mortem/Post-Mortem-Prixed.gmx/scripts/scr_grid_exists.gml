var map = argument0;
var value = argument1;
//show_debug_message(value);
for(i = 0; i < ds_grid_height(map); i++) {
    if(is_real(ds_grid_get(map, 0, i))) break;
    if(ds_grid_get(map, 0, i) == value) return true;
}

return false;

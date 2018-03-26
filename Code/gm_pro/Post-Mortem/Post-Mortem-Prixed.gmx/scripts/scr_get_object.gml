/// scr_get_item(id, key)

var map = ds_map_create();
var source = argument0[? argument1];

ds_map_copy(map, source);

map[? "alpha"] = scr_stat_create(r(), r(), r(), r());

return map;

/// scr_dest_hospital()

// Info
var map = ds_map_create();
map[? "name"] = "Hospital";
map[? "info"] = "Only the best at the local hose-petal.";
map[? "sprite"] = spr_destinations;
map[? "index"] = 1;

var i = 0;
var list = scr_list_create();
repeat(5) {
    list[| i++] = scr_character_create();
}

map[? "citizen"] = list;

return map;

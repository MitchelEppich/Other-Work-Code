/// scr_dest_barust()

// Info
var map = ds_map_create();
map[? "name"] = "Barust";
map[? "info"] = "The local restroom... I've been needing to go.";
map[? "sprite"] = spr_destinations;
map[? "index"] = 14;

var i = 0;
var list = scr_list_create();
repeat(5) {
    list[| i++] = scr_character_create();
}

map[? "citizen"] = list;

return map;

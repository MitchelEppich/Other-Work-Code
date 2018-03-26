/// scr_dest_library()

// Info
var map = ds_map_create();
map[? "name"] = "Library";
map[? "info"] = "A hotspot for the local brains, expect a crowd.";
map[? "sprite"] = spr_destinations;
map[? "index"] = 3;

var i = 0;
var list = scr_list_create();
repeat(5) {
    list[| i++] = scr_character_create();
}

map[? "citizen"] = list;

return map;

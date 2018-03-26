/// scr_dest_castle()

// Info
var map = ds_map_create();
map[? "name"] = "Castle";
map[? "info"] = "The local princess requested this grand empire.";
map[? "sprite"] = spr_destinations;
map[? "index"] = 8;

var i = 0;
var list = scr_list_create();
repeat(5) {
    list[| i++] = scr_character_create();
}

map[? "citizen"] = list;

return map;

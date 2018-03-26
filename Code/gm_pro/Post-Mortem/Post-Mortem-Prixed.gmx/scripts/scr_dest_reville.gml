/// scr_dest_reville()

// Info
var map = ds_map_create();
map[? "name"] = "Reville";
map[? "info"] = "A small town that is sure to consume your mind.";
map[? "sprite"] = spr_destinations;
map[? "index"] = 0;

var i = 0;
var list = scr_list_create();
repeat(5) {
    list[| i++] = scr_character_create();
}

map[? "citizen"] = list;

return map;

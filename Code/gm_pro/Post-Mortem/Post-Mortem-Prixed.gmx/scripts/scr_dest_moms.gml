/// scr_dest_moms()

// Info
var map = ds_map_create();
map[? "name"] = "Moms";
map[? "info"] = "I can smell the home cooked meal from here. Mom! Open!";
map[? "sprite"] = spr_destinations;
map[? "index"] = 12;

var i = 0;
var list = scr_list_create();
repeat(5) {
    list[| i++] = scr_character_create();
}

map[? "citizen"] = list;

return map;

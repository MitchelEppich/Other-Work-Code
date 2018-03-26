/// scr_dest_stadium()

// Info
var map = ds_map_create();
map[? "name"] = "Stadium";
map[? "info"] = "Never could go to a place that supports excercise.";
map[? "sprite"] = spr_destinations;
map[? "index"] = 4;

var i = 0;
var list = scr_list_create();
repeat(5) {
    list[| i++] = scr_character_create();
}

map[? "citizen"] = list;

return map;

/// scr_dest_park()

// Info
var map = ds_map_create();
map[? "name"] = "Park";
map[? "info"] = "Look at those trees...";
map[? "sprite"] = spr_destinations;
map[? "index"] = 13;

var i = 0;
var list = scr_list_create();
repeat(5) {
    list[| i++] = scr_character_create();
}

map[? "citizen"] = list;

return map;

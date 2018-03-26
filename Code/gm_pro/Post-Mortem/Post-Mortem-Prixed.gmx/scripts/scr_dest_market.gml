/// scr_dest_market()

// Info
var map = ds_map_create();
map[? "name"] = "Market";
map[? "info"] = "Nothing nutty about some nasty ass vegetables.";
map[? "sprite"] = spr_destinations;
map[? "index"] = 11;

var i = 0;
var list = scr_list_create();
repeat(5) {
    list[| i++] = scr_character_create();
}

map[? "citizen"] = list;

return map;

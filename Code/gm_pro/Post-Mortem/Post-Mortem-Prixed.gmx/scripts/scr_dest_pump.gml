/// scr_dest_pump()

// Info
var map = ds_map_create();
map[? "name"] = "Pump";
map[? "info"] = "I found my hose here, such a great bussiness.";
map[? "sprite"] = spr_destinations;
map[? "index"] = 10;

var i = 0;
var list = scr_list_create();
repeat(5) {
    list[| i++] = scr_character_create();
}

map[? "citizen"] = list;

return map;

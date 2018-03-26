/// scr_dest_factory()

// Info
var map = ds_map_create();
map[? "name"] = "Factory";
map[? "info"] = "Wear your headphones, else there will be blood.";
map[? "sprite"] = spr_destinations;
map[? "index"] = 9;

var i = 0;
var list = scr_list_create();
repeat(5) {
    list[| i++] = scr_character_create();
}

map[? "citizen"] = list;

return map;

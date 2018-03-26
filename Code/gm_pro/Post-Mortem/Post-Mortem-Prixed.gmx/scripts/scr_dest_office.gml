/// scr_dest_office()

// Info
var map = ds_map_create();
map[? "name"] = "Office";
map[? "info"] = "Breeding zombies since the dawn of time.";
map[? "sprite"] = spr_destinations;
map[? "index"] = 6;

var i = 0;
var list = scr_list_create();
repeat(5) {
    list[| i++] = scr_character_create();
}

map[? "citizen"] = list;

return map;

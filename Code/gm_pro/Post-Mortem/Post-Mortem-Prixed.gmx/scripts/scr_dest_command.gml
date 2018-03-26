/// scr_dest_command()

// Info
var map = ds_map_create();
map[? "name"] = "Command";
map[? "info"] = "Get the aluminum foil. You can not control me!";
map[? "sprite"] = spr_destinations;
map[? "index"] = 7;

var i = 0;
var list = scr_list_create();
repeat(5) {
    list[| i++] = scr_character_create();
}

map[? "citizen"] = list;

return map;

/// scr_dest_militia()

// Info
var map = ds_map_create();
map[? "name"] = "Militia";
map[? "info"] = "Have you seen the green men? Same...";
map[? "sprite"] = spr_destinations;
map[? "index"] = 5;

var i = 0;
var list = scr_list_create();
repeat(5) {
    list[| i++] = scr_character_create();
}

map[? "citizen"] = list;

return map;

/// scr_dest_spectra()

// Info
var map = ds_map_create();
map[? "name"] = "Spectra";
map[? "info"] = "Break those shades out, that reflection though.";
map[? "sprite"] = spr_destinations;
map[? "index"] = 15;

var i = 0;
var list = scr_list_create();
repeat(5) {
    list[| i++] = scr_character_create();
}

map[? "citizen"] = list;

return map;

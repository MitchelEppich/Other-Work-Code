/// scr_towndb()
global.town = ds_map_create();

var d = global.dest;

// Town 1
var t1 = scr_list_create(
    d[? "farm"], 
    d[? "library"], 
    d[? "reville"], 
    d[? "pump"], 
    d[? "moms"]
);

global.town[? "reville"] = t1;

/// scr_element_create(id, text, xoffset, yoffset, scale, color, alpha, usage, name, info, stat, index, action)

var list = argument0;

if (argument0 == -1) 
    list = ds_map_create();

// Add customizations
ds_map_add(list, "text", argument1);
ds_map_add(list, "xoffset", argument2);
ds_map_add(list, "yoffset", argument3);
ds_map_add(list, "scale", argument4);
ds_map_add(list, "color", argument5);
ds_map_add(list, "alpha", argument6);
ds_map_add(list, "usage", argument7);
ds_map_add(list, "name", argument8);
ds_map_add(list, "info", argument9);
ds_map_add(list, "stat", argument10);
ds_map_add(list, "index", argument11);
ds_map_add(list, "action", argument12);

if (argument0 == -1)
    return list;

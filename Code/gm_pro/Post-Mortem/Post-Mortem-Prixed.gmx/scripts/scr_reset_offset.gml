/// scr_reset_offset(list)
for (var i = 0; i < ds_list_size(argument0); i++) {
    var el = list[| i];
    var el_base = list[| 0];
    
    el[? "yoffset"] = el_base[? "yoffset"];
    el[? "xoffset"] = el_base[? "xoffset"];
}

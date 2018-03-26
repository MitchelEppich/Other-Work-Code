/// scr_dev_cmd_whatis (type)
if(!instance_exists(argument0)) { unknown = true; return 0 }
else { 
    var camera = instance_find(obj_view_master.object_index, 0);
    camera.x = argument0.x; 
    camera.y = argument0.y;
    return object_get_name(argument0.object_index); 
}

/// scr_dev_cmd_whatis (type)
if(!instance_exists(argument0)) { unknown = true; return 0 }
else with real(argument0) return object_get_name(argument0.object_index);

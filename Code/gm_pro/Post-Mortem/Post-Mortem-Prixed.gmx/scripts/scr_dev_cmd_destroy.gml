/// scr_dev_cmd_destroy (id)
if(!instance_exists(argument0)) unknown = true;
else with real(argument0) instance_destroy();

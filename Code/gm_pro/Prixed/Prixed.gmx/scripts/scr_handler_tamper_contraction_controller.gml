var tamper_details = argument1;

var inst = instance_place(x, y, obj_npc);
if(inst != noone) {
    scr_handler_tamper_deploy_controller(argument0, inst, tamper_details);
}

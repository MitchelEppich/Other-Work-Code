var this = argument0;
if(argument1 == 1) depth = -y;

if(global.pause) {
var inst = instance_place(x, y, obj_npc);
if(inst != noone) {
    
    if(tamper_define != "") {
        scr_handler_tamper_deploy_controller(this, inst, this.tamper_define);
    }
 
    if(death_anim != -1) {   
        var inst_death = instance_create(x, y, death_anim);
        inst_death.depth = inst.depth - 5;
    }  
    
    with this instance_destroy();
}
} else scr_pause_object(this, 0);

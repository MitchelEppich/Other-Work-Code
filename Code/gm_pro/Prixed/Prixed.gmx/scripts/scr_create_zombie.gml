///scr_create_zombie(x, y)

var xx = argument0;
var yy = argument1;


var inst = instance_create(xx, yy, obj_human);
with inst.id {
    scr_handler_npc_controller();
    tag = "zombie";
    populated = false;
    hit_points = 20;
    base_damage = 10;
    hspd = random_range(0.3, 0.6);
    acceleration = 0.5;
    jump_height = 4;
    targets = obj_npc;
    team = "enemy";
    mass = 70;
    scale = 4;
    colour = make_colour_rgb(40, 115, 29);
    alpha = 1;
    
    scr_handler_weapon_selector_controller(id, 0);
    selected_attack = scr_handler_weapon_selector_update(id);
    scr_weapon_controller(-1, id, 0, 0, 0, 0, 0, 0, 0);
    scr_ai_controller(200, 10, 10);
    scr_animation_controller(id, spr_human);
    scr_report(id, "spawn");
}

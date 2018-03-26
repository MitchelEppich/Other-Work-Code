///scr_create_tank(x, y)
var xx = argument0;
var yy = argument1;


var inst = instance_create(xx, yy, obj_human);
with inst.id {
    scr_handler_npc_controller();
    tag = "tank";
    populated = false;
    hit_points = 50;
    base_damage = 40;
    hspd = random_range(0.2, 0.3);
    acceleration = 0.5;
    jump_height = 4;
    targets = obj_npc;
    team = "enemy";
    mass = 140;
    scale = 5;
    colour = make_colour_rgb(177, 3, 3);
    alpha = 1;
    
    scr_handler_weapon_selector_controller(id, 0);
    selected_attack = scr_handler_weapon_selector_update(id);
    scr_weapon_controller(-1, id, 0, 0, 0, 0, 0, 0, 0);
    scr_ai_controller(200, 10, 10);
    scr_animation_controller(id, spr_human);
    scr_report(id, "spawn");
}

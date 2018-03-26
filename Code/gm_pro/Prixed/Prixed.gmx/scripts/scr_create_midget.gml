///scr_create_midget(x, y)
var xx = argument0;
var yy = argument1;


var inst = instance_create(xx, yy, obj_human);
with inst.id {
    scr_handler_npc_controller();
    tag = "midget";
    populated = false;
    hit_points = 5;
    base_damage = 1;
    hspd = random_range(0.8, 1.2);
    acceleration = 0.5;
    jump_height = 2;
    targets = obj_npc;
    team = "enemy";
    mass = 50;
    scale = 3;
    colour = make_colour_rgb(18, 102, 150);
    alpha = 1;
    
    scr_handler_weapon_selector_controller(id, 0);
    selected_attack = scr_handler_weapon_selector_update(id);
    scr_weapon_controller(-1, id, 0, 0, 0, 0, 0, 0, 0);
    scr_ai_controller(200, 10, 10);
    scr_animation_controller(id, spr_human);
    scr_report(id, "spawn");
}

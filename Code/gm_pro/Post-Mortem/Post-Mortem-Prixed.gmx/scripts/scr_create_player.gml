///scr_create_player(x, y)
var xx = argument0;
var yy = argument1;


var inst = instance_create(xx, yy, obj_human);
global.player = inst;
with inst {
    scr_handler_npc_controller();
    tag = "player";
    populated = true;
    hit_points = 100;
    base_damage = 10;
    hspd = 0.5;
    acceleration = 0.5;
    jump_height = 4;
    targets = obj_npc;
    team = "friend";
    mass = 70;
    scale = 4;
    colour = make_colour_rgb(254, 217, 196);
    alpha = 1;
    
    scr_handler_weapon_selector_controller(id, -1);
    selected_attack = scr_handler_weapon_selector_update(id);
    scr_weapon_controller(-1, id, 0, 0, 0, 0, 0, 0, 0);
    scr_ai_controller(200, 10, 10);
    scr_animation_controller(id, spr_human);
    scr_report(id, "spawn");
}

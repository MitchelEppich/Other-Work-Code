///scr_create_ghost(x, y, id)
var xx = argument0;
var yy = argument1;
var this = argument2;


var inst = instance_create(xx, yy, obj_human);

with inst {
    scr_handler_npc_controller();
    tag = "ghost";
    populated = this.populated;
    hit_points = this.hit_points;
    base_damage = this.base_damage;
    hspd = this.hspd;
    acceleration = 0;
    jump_height = 15;
    targets = this.targets;
    team = this.team;
    mass = this.mass;
    scale = this.scale;
    
    creator = argument2;
    
    colour = this.colour;
    alpha = 0.3;
    
    scr_handler_weapon_selector_controller(id, -1);
    selected_attack = this.selected_attack;
    scr_weapon_controller(-1, id, 0, 0, 0, 0, 0, 0, 0);
    scr_ai_controller(200, 10, 10);
    scr_animation_controller(id, spr_human);
    scr_report(id, "");
}

///scr_handler_npc_update(id)
var this = argument0;

// Wrapping
move_wrap(1, 0, 0);

// Get Direction
if(hspeed != 0) dir = (hspeed / abs(hspeed)); 

if(!global.paused || tag == "ghost") {
scr_animation_update(this);
scr_physics_controller(this, mass);

//show_debug_message(ds_map_size(inventory));
//show_debug_message(ds_map_find_value(inventory, "fireball"));

////////////////////////////////////////////////////////////////////////

if(keyboard_check_pressed(global.chat) && populated) {
    chat = !chat;
}

if (alive) {

    if(max_hit_points == -10) max_hit_points = hit_points;
    if(hit_points > max_hit_points) hit_points = max_hit_points;
    
    ///////////////////////////////////////////////////////////////////////
    //show_debug_message(string(this.weapon_range) + " : " + string(this.selected_attack));
    // Controller
    if(populated && !interacting) {
        if keyboard_check_released(vk_anykey) action = "";
        if keyboard_check(global.right) action = "move_right";
        if keyboard_check(global.left) action = "move_left";
        if keyboard_check_pressed(global.jump) action = "jump";
        //if keyboard_check_released(global.chat) action = "chat";
        if(tag != "ghost") {
            if keyboard_check(global.interact) action = "interact";
            if keyboard_check_pressed(global.attack) action = "attack";
        }
        
    } else if(!populated) {
        scr_ai_update(this);
    }
    
    ///////////////////////////////////////////////////////////////////////////
    
    // Watch Handlers
    if(hit_points <= 0) alive = false;
    if(abs(hspeed) > global.max_speed) hspeed = dir * global.max_speed;

    if(stealth) {
        hspeed = 0;
        vspeed = 0;
    }
    
    if(stealth) interacting = true;
    else interacting = false;
    
    if(vspeed == 0)depth = -y;
    
    // Dynamic Handlers
    if (global.tick mod 100 == 0) {
    }
    
    //////////////////////////////////////////////////////////////////////
    // Scripts
    scr_interact_stealth(this);
    scr_weapon_update(this, item_selected + hotbar_start);

    scr_movement_controller(this, hspd, jump_height);
    
    if(tag != "ghost") {
        if(populated)
            scr_handler_weapon_selector_update(this);
           
        targeted = scr_handler_target_update(this);    
            
        scr_handler_terrain_update(this);
        scr_handler_tamper_update(this);
        
        scr_handler_leveling(this, -1);
        scr_handler_rewards(this, -1);
    }
    if(!alive) scr_report(this, "death");
    
} else {
    hspeed = 0;
    if(this.death_tick > 50) {
        with this instance_destroy();
    } else this.death_tick++;
}
//////////////////////////////////////////////////////////////////////
} else scr_pause_object(this, 0);
// Watches
//if(!alive) with this instance_destroy();

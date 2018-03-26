///scr_handler_tamper_deploy_controller(id, other, tamper_details)
var this = argument0;
var who = argument1;
var tamper_details = argument2;

if(!scr_check_contains(who, tamper_details)) {
    //who.tampers = tamper_details;
    ds_list_add(who.tampers, tamper_details);
    // This is were we decrease the opponents health
    var current_level = 1;
    if(this == obj_human) current_level = this.level;
    var damage = ceil(0.23 * (this.weapon_damage * current_level));
    who.hit_points -= damage;
    // Create hit caption
    var caption = instance_create(who.x, who.y, obj_caption);
    caption.text = string(damage);
    caption.colour = c_red;
    caption.spd = 4;
    caption.alarm[0] = room_speed;
    
    
    ///////////////////////
    if(who.hit_points <= 0) {
        if(this != obj_human) {
            var dealer = this.creator;
        } else var dealer = this;
        
        if(dealer != noone) scr_handler_inventory_inherit(dealer, who);
    }
}

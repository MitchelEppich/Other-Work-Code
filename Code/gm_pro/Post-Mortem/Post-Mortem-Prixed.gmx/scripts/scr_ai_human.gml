/// scr_ai_human (this, enable)
var this = argument0;
var enabled = argument1;

if (!enabled) {

    //* Select target *//
    
    // If target does not exists
    if (!instance_exists(this.target)) { this.target = noone; }
    
    // Find nearest package
    if (this.package == noone && this.target == noone) 
        { this.target = instance_nearest (this.x, this.y, obj_package); }
        
    // Find holder to that package
    else if (this.target != noone && instance_exists (this.target) && 
    object_get_name (this.target.object_index) == "obj_package" && 
    this.target.target != noone && this.target.team != this.team) 
        { this.target = this.target.target; }
        
    // Find player
    else if (this.target == noone && instance_exists(global.player)) 
        { this.target = global.player; }
        
    // Found package now hold on to it
    else if (this.package != noone) 
        { this.target = noone; }

    //* Choose key *//
    /*
        Commands :
            -   Follow
            -   Attack
            -   Protect
            -   Acquire
            -   Wander
            -   Sneak
            -   Idle
    */

    //* Helper of wander and idle *//
    if (this.target == noone && intel_distance <= 0) {
        intel_distance = room_speed * max (2, irandom(4));
        intel_dir = choose(0, 1, 2);
    } 
    else if (this.x - 50 < 0 && this.x + 50 > room_width) 
        { intel_dir = (intel_dir == 1); } 
    else if (this.target != noone) 
        { intel_distance = 0; } 
    else if (intel_distance > 0) 
        { intel_distance--; }
    
    //* Now decide what the AI will do *//
    
    // Jump
    this.key_space = 
    // Check if target is above
        ((this.target != noone && 
        instance_exists(this.target) && 
        (abs (this.target.y - this.y) > 10) && 
        
        (physics_test_overlap (this.x + 10, this.y - 10, 0, obj_collider) || 
        physics_test_overlap (this.x - 10, this.y - 10, 0, obj_collider)) ||
        
    // If no target check if ledge is meet
        this.target == noone && 
        
        (physics_test_overlap (this.x + 10, this.y - 10, 0, obj_collider) || 
        physics_test_overlap (this.x - 10, this.y - 10, 0, obj_collider)))) &&
    
    // For all check if ledge is too tall
        !(physics_test_overlap (this.x + 10, this.y - 20, 0, obj_collider) || 
        physics_test_overlap (this.x - 10, this.y - 20, 0, obj_collider));
    
    // Sneak
    if (instance_exists(this.target)) 
        { this.key_down = 
            (this.target.target != this && 
            abs (this.x - this.target.x) > 10 &&
            abs (this.x - this.target.x) < 30); }
    
    // Protect
    if (instance_exists(this.target) && 
    this.target.team == this.team && 
    this.target.target != noone) 
        { this.target = this.target.target; }
    
    // Attack
    if (instance_exists(this.target) && 
    this.target.team != this.team) { this.key_modify = abs (this.target.x - this.x) <= 5 && 
                                    object_get_name (this.target.object_index) == "obj_human"; }
    
    // Follow
    if (instance_exists(this.target)) { this.key_left = (sign (this.target.x - this.x) == -1 && 
                                        abs (this.target.x - this.x) > 5); }
    if (instance_exists(this.target)) { this.key_right = (sign (this.target.x - this.x) == 1 && 
                                        abs (this.target.x - this.x) > 5); }
    
    // Acquire
    if (instance_exists(this.target) && 
        object_get_name (this.target.object_index) == "obj_package") {
            this.key_interact = this.package == noone && 
            physics_test_overlap (this.x, this.y, 0, obj_package) ||
            this.package != noone && 
            this.phy_speed_x < this.spd/2; 
    }
                        
    // Wander
    if (this.target == noone) { this.key_right = (intel_dir == 0); }
    if (this.target == noone) { this.key_left = (intel_dir == 1); }
    
}

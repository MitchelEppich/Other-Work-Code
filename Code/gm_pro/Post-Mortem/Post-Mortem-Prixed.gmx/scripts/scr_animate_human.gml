/// scr_animate_human(this)
var this = argument0;

if(this.stat[? "alive"]) {
    if (this.stat[? "grounded"]) {

        // Running
        if (abs(phy_speed_x) >= this.stat[? "speed"] * (3/4)) {
            scr_animate_update(this, this.sprite_index, 5 + (5 * this.stealth), 5);
        } else   
        // Walking
        if (abs(phy_speed_x) > 0) {
            scr_animate_update(this, this.sprite_index, 1 + (9 * this.stealth), 5);
        } else
        // Attack
        if (this.attacking) {
            scr_animate_update (this, this.sprite_index, 19, 3);
            this.attacking = !(this.image_index == 19 + 3 - 1); // -1 to meet the maximum frame
        } else
        // Stand
        if (phy_speed_x == 0) {
            scr_animate_update(this, this.sprite_index, 0 + (9 * this.stealth), 1);
        }
    } else if (!this.stat[? "grounded"]){
    
        // Falling
        scr_animate_update(this, this.sprite_index, 27, 1);
        
    }
} else scr_animate_update(this, this.sprite_index, 18, 1); // Death

var this = argument0;
var whois = argument1;

if whois == noone || !instance_exists(whois) exit;

if(this.last_x == 0|| this.last_y == 0) {
    if(whois != noone) {
        this.last_x = whois.x;
        this.last_y = whois.y;
    }
}

if keyboard_check(global.interact) && count < 7 {
    whois.x = this.x;
    whois.y = this.y;
    whois.stealth = true;
    whois.depth = this.depth + 5;

    if(global.tick mod this.rate == 0) {
        whois.hit_points += this.hit_points;
        count++;
        //whois.energy += this.energy;
    }
} else if count >= 7 || !keyboard_check(global.interact) {
    if(whois.populated && count >= 7 && this.isShop) {
        var inst = instance_create(0, 0, obj_shop);
        inst.shop_name = string_delete(object_get_name(this.object_index), 1, 4);
    }
    if whois != noone {
        whois.x = this.last_x;
        whois.y = this.last_y;
        this.last_x = 0;
        this.last_y = 0;
        whois.stealth = false;
        this.occupied = noone; 
        refuel = true;  
    }
}

///scr_weapon_update(id, type)

var this = argument0;
var type = argument1;
type = string(ds_grid_get(inventory, 0, type));

var ammo = real(ds_grid_get(inventory, 1, item_selected));

//show_debug_message(ammo);
if(ammo == 0 || item_selected == -1 || type == "gold") {
    this.attack = false;
    exit;
}

//if(populated) show_debug_message(item_selected);

if(this.action == "attack") {
    if(!this.attack) {
        if(ammo != -1) ds_grid_add(inventory, 1, item_selected + hotbar_start, -1);
        this.attack = true;
        switch(type) {
            case "punch":
                scr_melee_punch(this, this.targeted, true);
                break;
            case "stab":
                scr_melee_stab(this, this.targeted, true);
                break;
            case "hack":
                scr_melee_hack(this, this.targeted, true);
                break;
            case "fireball":
                scr_cast_fireball(this, true);
                break;
            case "teleport":
                scr_cast_teleport(this);
                break;
            case "arrow":
                scr_range_arrow(this, true);
                break;
            case "javelin":
                scr_range_javelin(this, true);
                break;
            case "heal":
                scr_cast_heal(this, true);
                break;
            case "regenerate":
                scr_cast_regenerate(this, true);
                break;
            case "harden":
                scr_cast_harden(this, true);
                break;
        }
    }
} else {
    this.attack = false;
    switch(type) {
        case "punch":
            scr_melee_punch(this, -1, false);
            break;
        case "stab":
            scr_melee_stab(this, -1, false);
            break;
        case "hack":
            scr_melee_hack(this, -1, false);
            break;
        case "fireball":
            scr_cast_fireball(this, false);
            break;
        case "arrow":
            scr_range_arrow(this, false);
            break;
        case "javelin":
            scr_range_javelin(this, false);
            break;
        case "heal":
            scr_cast_heal(this, false);
            break;
        case "regenerate":
            scr_cast_regenerate(this, false);
            break;
        case "harden":
            scr_cast_harden(this, false);
            break;
    }
}

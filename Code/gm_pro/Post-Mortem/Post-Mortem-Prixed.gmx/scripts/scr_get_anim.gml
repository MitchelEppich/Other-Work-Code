var this = argument0;
var type = string(ds_grid_get(inventory, 0, item_selected + hotbar_start));

var c = 0;

switch(type) {
    case "punch":
    c = 20;
    break;
    case "fireball":
    c = 17;
    break;
    case "stab":
    c = 7;
    break;
    case "hack":
    c = 8;
    break;
    case "spawn":
    c = 15;
    break;
    case "raise":
    c = 16;
    break;
    case "slash":
    c = 9;
    break;
    case "arrow":
    c = 18;
    break;
    case "javelin":
    c = 19;
    break;
}

return c;

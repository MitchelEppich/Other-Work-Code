var this = argument0;
var item = "gold";
var amount = argument1;

if(global.tick mod 20 == 0) {
    scr_inventory_add(this, "gold", (1 * ceil(((level * 0.3) + (global.wave * 0.7)))));
}

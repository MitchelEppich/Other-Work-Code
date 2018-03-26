var this = argument0;
var num = argument1;

//show_debug_message(num);
if(num == -1) {
    item_selected = 0;
} else {
    item_selected = 0;
    scr_inventory_add(this, 
    choose("hack", "stab", "fireball", "slash", "arrow", "javelin", "punch"), 
    -1);
}

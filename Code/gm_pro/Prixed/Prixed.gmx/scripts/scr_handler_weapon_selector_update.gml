var this = argument0;
var change = 0;
var modi = false;

if keyboard_check(global.modifier) modi = true;

if keyboard_check_pressed(global.scrollUp) change = 1;
if keyboard_check_pressed(global.scrollDown) change = -1;

if(!modi) {
item_selected += change;

if(item_selected < 0) item_selected = 8 - 1;
else if(item_selected > 8 - 1) item_selected = 0;

if(scr_grid_get_size(inventory, "height") < item_selected) return -1;
else return item_selected;
} else {
    hotbar_start += change;
    
    var size = ds_grid_height(inventory);
    
    if(hotbar_start < 0) hotbar_start = size - 1;
    else if(hotbar_start > size - 1) hotbar_start = 0;
}

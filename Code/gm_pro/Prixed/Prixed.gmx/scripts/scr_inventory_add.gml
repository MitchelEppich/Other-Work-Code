var this = argument0;
var item = argument1;
var amount = argument2;

if(scr_grid_exists(this.inventory, item)) {
    var num = scr_grid_find_value(this.inventory, item);
    ds_grid_add(this.inventory, 1, num, amount);
} else {
    var height = scr_grid_get_size(this.inventory, "height");
    ds_grid_set(this.inventory, 0, height, item);
    ds_grid_set(this.inventory, 1, height, amount);
}


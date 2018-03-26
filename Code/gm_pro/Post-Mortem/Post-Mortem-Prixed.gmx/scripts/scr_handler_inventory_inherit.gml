var this = argument0;
var who = argument1;

for(var i = 0; i < scr_grid_get_size(who.inventory, "height"); i++) {
    var item = ds_grid_get(who.inventory, 0, i);
    if(item == "punch") continue;
    var amount = ds_grid_get(who.inventory, 1, i);
    
    if(amount == -1) amount = floor(random_range(1, 50));
    
    scr_inventory_add(this, item , amount);
}

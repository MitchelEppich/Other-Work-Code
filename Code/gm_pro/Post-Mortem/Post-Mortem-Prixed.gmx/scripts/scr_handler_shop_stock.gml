var map = argument0;

shop_inventory = ds_grid_create(64, 64);

for(var i = 0; i < ds_list_size(map); i++) {
    var item = ds_list_find_value(map, i);
    ds_grid_add(shop_inventory, 0, i, item);
    ds_grid_add(shop_inventory, 1, i, ds_grid_get(global.item_preset, 1, scr_grid_find_value(global.item_preset, item)));
    ds_grid_add(shop_inventory, 2, i, ds_grid_get(global.item_preset, 2, scr_grid_find_value(global.item_preset, item)));
}

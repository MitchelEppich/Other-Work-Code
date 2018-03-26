shop = ds_list_find_index(global.shops, "hospital");
clerk = shop + 1;

var shop_stock = ds_list_create();

ds_list_add(shop_stock,
"regenerate",
"heal",
"harden"
);

scr_handler_shop_stock(shop_stock);

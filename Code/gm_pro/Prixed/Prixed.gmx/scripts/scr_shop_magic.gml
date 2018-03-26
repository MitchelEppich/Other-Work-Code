shop = ds_list_find_index(global.shops, "magic");
clerk = shop + 1;

var shop_stock = ds_list_create();

ds_list_add(shop_stock,
"fireball",
"teleport",
"harden"
);

scr_handler_shop_stock(shop_stock);

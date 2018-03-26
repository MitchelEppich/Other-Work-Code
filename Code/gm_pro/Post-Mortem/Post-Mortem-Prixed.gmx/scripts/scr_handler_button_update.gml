var type = argument0;
type = string_lower(type);

switch(type) {
    case "shop_exit":
    with obj_shop instance_destroy();
    global.paused = false;
    break;
    case "shop_purchase":
    with obj_shop transaction = true;
    break;
    case "shop_left_amt":
    with obj_shop change_amt = -1;
    break;
    case "shop_right_amt":
    with obj_shop change_amt = 1;
    break;
}

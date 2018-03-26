var this = argument0;

var amount = ds_grid_get(this.shop_inventory, 1, this.selection);
amount += req_amt;

//Amount change
if(change_amt != 0 && amount + change_amt > 0) {
    req_amt += change_amt;
    change_amt = 0;
}
  
// Transaction Handler
if(this.transaction && amount > 0) {
    var who = global.player;
    var item = ds_grid_get(this.shop_inventory, 0, this.selection);
    var price = ds_grid_get(this.shop_inventory, 2, this.selection);
    var gold = ds_grid_get(who.inventory, 1, scr_grid_find_value(who.inventory, "gold"));
    
    if(price * amount <= gold) {
        scr_inventory_add(who, item, amount);
        ds_grid_add(who.inventory, 1, scr_grid_find_value(who.inventory, "gold"), -(price * amount));
        this.transaction = 0;
    } else {
        this.transaction = -1;
        show_debug_message("Not enough gold.");
    }
}


// Selection Handler
var change = 0;
var selection = this.selection;


if keyboard_check_pressed(global.scrollUp) change = 1;
if keyboard_check_pressed(global.scrollDown) change = -1;

selection += change;

if(change != 0) this.req_amt = 0;

var h = scr_grid_get_size(this.shop_inventory, "height");

if(selection < 0) selection = h - 1;
else if(selection > h - 1) selection = 0;

return selection;

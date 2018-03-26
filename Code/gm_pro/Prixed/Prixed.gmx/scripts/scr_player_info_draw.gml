///scr_player_info_draw(id)
var this = argument0;

draw_set_halign(fa_left);
draw_set_colour(c_black);
draw_text_transformed(875, 700, "Level : " + string(this.level), 0.5, 0.5, 0);
draw_text_transformed(875, 720, "Gold : " + string(ds_grid_get(this.inventory, 1, scr_grid_find_value(this.inventory, "gold"))), 0.5, 0.5, 0);
draw_text_transformed(875, 740, "Wave : " + string(global.wave), 0.5, 0.5, 0);

//For info on weapon!

var weapon_name = ds_grid_get(inventory, 0, item_selected + hotbar_start);
var amount = ds_grid_get(inventory, 1, item_selected + hotbar_start);
if (amount == -1) amount = "infinity";

if(string(ds_grid_get(inventory, 0, item_selected + hotbar_start)) != "0") {

    draw_set_halign(fa_left);
    draw_set_colour(c_black);
    draw_text_transformed(20, 700, string(weapon_name), 0.5, 0.5, 0);
    draw_text_transformed(20, 720, "Amt : " + string(amount), 0.5, 0.5, 0);
    //scr_draw_string(20, 700, string(weapon_name), 2, fa_left, 1, -1);
    //scr_draw_string(20, 720, "Amt : " + string(amount), 2, fa_left, 1, -1);
}


///scr_shop_draw(type, id)
var type = argument0;
var this = argument1;

var scale = 4;

var width = 10;
var height = 5;

var spr_shop = spr_shops;
var spr = spr_shop_screen;

var xoffset = (width * sprite_get_width(spr) * scale);

var cx = (view_wport[0] - (width * sprite_get_width(spr) * scale))/2;
var cy = (view_hport[0] - (height * sprite_get_height(spr) * scale))/2;

// Draw message box
scr_display_message_box(width, height, scale, cx, cy);

// Find shop to display
var num = ds_list_find_index(global.shops, type) * 2;

draw_sprite_ext(spr_shop, num, cx + 30, cy + 30, 8, 8, 0, -1, 1);
draw_sprite_ext(spr_shop, num + 1, cx + 30, cy + 30, 8, 8, 0, -1, 1);

draw_text_transformed(cx + 80 + xoffset/2, cy + 30, string(type), scale, scale, 0);
//scr_draw_string(cx + 80 + xoffset/2, cy + 30, string(type), scale, fa_center, 1, -1);

// Actual shop
var map = shop_inventory;
var attack = selection;
var attack_id = string(ds_grid_get(map, 0, attack));

var amt = ds_grid_get(global.item_preset, 1, scr_grid_find_value(global.item_preset, attack_id));
var buyer_amt = amt + this.req_amt;

var price = ds_grid_get(global.item_preset, 2, scr_grid_find_value(global.item_preset, attack_id));

//Main overview
draw_rectangle_colour(cx + xoffset/2, cy + 75, cx + 150 + xoffset/2, cy + 75 + ((sprite_get_height(spr_font) * scale)), make_colour_rgb(238, 232, 212), -1, -1, -1, 0);
//scr_display_tab(cx + 5 + xoffset/2, cy + 105, ds_list_find_index(global.items, attack_id), 9, -1);


draw_set_halign(fa_center);
draw_set_colour(c_black);
draw_text_transformed(cx + 80 + xoffset/2, cy + 30, string(type), scale, scale, 0);
//scr_draw_string(cx + 80 + xoffset/2, cy + 80, attack_id, scale/2, fa_center, 1, -1);
scr_draw_button(cx + xoffset/2 + 65, cy + 270, "Purchase", 0, 2, "shop_purchase");
scr_draw_button(cx + xoffset/1.16, cy + 270, "Exit", 0, 2, "shop_exit");


draw_set_halign(fa_center);
draw_set_colour(c_black);
//Purchase
draw_text_transformed(cx + xoffset/2.67 + 5, cy + 90, "Type", scale/2, scale/2, 0);
//scr_draw_string(cx + xoffset/2.67 + 5, cy + 90, "Type", scale/2, fa_center, 1, -1);
draw_rectangle_colour(cx - 40 + xoffset/2.67, cy + 110, cx + 50 + xoffset/2.67, cy + 110 + ((sprite_get_height(spr_font) * scale)), make_colour_rgb(238, 232, 212), -1, -1, -1, 0);
draw_text_transformed(cx + xoffset/3 + 35, cy + 110 + 5, "Normal", scale/2, scale/2, 0);
//scr_draw_string(cx + xoffset/3 + 35, cy + 110 + 5, "Normal", scale/2, fa_center, 1, -1);


draw_set_halign(fa_center);
draw_set_colour(c_black);
//Purchase amt
draw_text_transformed(cx + xoffset/2.67 + 5, cy + 140, "Amt", scale/2, scale/2, 0);
//scr_draw_string(cx + xoffset/2.67 + 5, cy + 140, "Amt", scale/2, fa_center, 1, -1);
draw_rectangle_colour(cx - 40 + xoffset/2.67, cy + 160, cx + 50 + xoffset/2.67, cy + 160 + ((sprite_get_height(spr_font) * scale)), make_colour_rgb(238, 232, 212), -1, -1, -1, 0);
draw_text_transformed(cx + xoffset/3 + 30, cy + 160 + 5, string(buyer_amt), scale/2, scale/2, 0);
//scr_draw_string(cx + xoffset/3 + 30, cy + 160 + 5, string(buyer_amt), scale/2, fa_center, 1, -1);

// Left arrow
scr_draw_button(cx + xoffset/2.67 + 65, cy + 168, "", 1, 2, "shop_right_amt");


draw_set_halign(fa_center);
draw_set_colour(c_black);
draw_text_transformed(cx + xoffset/2.67 + 5, cy + 190, "Cost", scale/2, scale/2, 0);
//scr_draw_string(cx + xoffset/2.67 + 5, cy + 190, "Cost", scale/2, fa_center, 1, -1);
draw_rectangle_colour(cx - 40 + xoffset/2.67, cy + 210, cx + 50 + xoffset/2.67, cy + 210 + ((sprite_get_height(spr_font) * scale)), make_colour_rgb(238, 232, 212), -1, -1, -1, 0);
draw_text_transformed(cx + xoffset/3 + 30, cy + 210 + 5, string(buyer_amt * price), scale/2, scale/2, 0);
//scr_draw_string(cx + xoffset/3 + 30, cy + 210 + 5, string(buyer_amt * price), scale/2, fa_center, 1, -1);

// Left arrow
scr_draw_button(cx + xoffset/2.67 - 27, cy + 168, "", 1, -2, "shop_left_amt");

// Stats
var this = global.player;
var map = this.inventory;
if(scr_grid_exists(map, attack_id)) attack = scr_grid_find_value(map, attack_id);
else attack = -1;
var currentAmt = ds_grid_get(map, 1, attack);
if(currentAmt == -1) currentAmt = "infinity";
if(attack == -1) currentAmt = "none";


draw_set_halign(fa_center);
draw_set_colour(c_black);
draw_text_transformed(cx + xoffset/1.17 + 5, cy + 80, "Stats", scale/2, scale/2, 0);
//scr_draw_string(cx + xoffset/1.17 + 5, cy + 80, "Stats", scale/2, fa_center, 1, -1);
draw_rectangle_colour(cx - 50 + xoffset/1.17, cy + 95, cx + 50 + xoffset/1.17, cy + 95 + ((sprite_get_height(spr_font) * scale)), make_colour_rgb(238, 232, 212), -1, -1, -1, 0);
draw_text_transformed(cx + xoffset/1.17 + 5, cy + 100, this.tag, scale/2, scale/2, 0);
//scr_draw_string(cx + xoffset/1.17 + 5, cy + 100, this.tag, scale/2, fa_center, 1, -1);


draw_set_halign(fa_center);
draw_set_colour(c_black);
draw_text_transformed(cx + xoffset/1.17 + 5, cy + 115, "Amt", scale/2, scale/2, 0);
//scr_draw_string(cx + xoffset/1.17 + 5, cy + 115, "Amt", scale/2, fa_center, 1, -1);
draw_rectangle_colour(cx - 50 + xoffset/1.17, cy + 125, cx + 50 + xoffset/1.17, cy + 125 + ((sprite_get_height(spr_font) * scale)), make_colour_rgb(238, 232, 212), -1, -1, -1, 0);
draw_text_transformed(cx + xoffset/1.17 + 5, cy + 130, string(currentAmt), scale/2, scale/2, 0);
//scr_draw_string(cx + xoffset/1.17 + 5, cy + 130, string(currentAmt), scale/2, fa_center, 1, -1);


draw_set_halign(fa_center);
draw_set_colour(c_black);
draw_text_transformed(cx + xoffset/1.17 + 5, cy + 145, "Gold", scale/2, scale/2, 0);
//scr_draw_string(cx + xoffset/1.17 + 5, cy + 145, "Gold", scale/2, fa_center, 1, -1);
draw_rectangle_colour(cx - 50 + xoffset/1.17, cy + 155, cx + 50 + xoffset/1.17, cy + 155 + ((sprite_get_height(spr_font) * scale)), make_colour_rgb(238, 232, 212), -1, -1, -1, 0);
draw_text_transformed(cx + xoffset/1.17 + 5, cy + 160, string(ds_grid_get(this.inventory, 1, scr_grid_find_value(this.inventory, "gold"))), scale/2, scale/2, 0);
//scr_draw_string(cx + xoffset/1.17 + 5, cy + 160, string(ds_grid_get(this.inventory, 1, scr_grid_find_value(this.inventory, "gold"))), scale/2, fa_center, 1, -1);

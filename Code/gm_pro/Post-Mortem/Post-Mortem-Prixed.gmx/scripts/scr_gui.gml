///scr_gui(id)
var this = argument0;

//Drawing Background for Gui
var size = 4;
draw_sprite_ext(spr_gui, 5, 10, 10, size, size, 0, -1, 1);
draw_sprite_ext(spr_gui, 6, 10, 10 + (16 * size), size, size, 0, -1, 1);
draw_sprite_ext(spr_gui, 2, 10 + (16 * size), 10 + (7 * size), size, size, 0, -1, 1);
draw_sprite_ext(spr_gui, 2, 10 + (16 * size * 2), 10 + (7 * size), size, size, 0, -1, 1);
draw_sprite_ext(spr_gui, 2, 10 + (16 * size * 3), 10 + (7 * size), size, size, 0, -1, 1);
draw_sprite_ext(spr_gui, 2, 10 + (16 * size * 4), 10 + (7 * size), size, size, 0, -1, 1);
draw_sprite_ext(spr_gui, 1, 10 + (16 * size * 5), 10 + (7 * size), size, size, 0, -1, 1);

for(i = 0; i < ceil(view_wport[0]/ (16 * 4)); i++) {
    draw_sprite_ext(spr_gui, 3, (16 * size) * i, 650, size, size, 0, -1, 1);
    draw_sprite_ext(spr_gui, 4, (16 * size) * i, 650 + (16 * size), size, size, 0, -1, 1);
}

// Info Draw

var scale = 3;
var size = 50;

if(global.current_hit_points == 0) global.current_hit_points = this.hit_points;
for(var i = 0; i < size; i++) {
    
    var c;    

    if((global.current_hit_points / size) * i <= this.hit_points) c = 1;
    else if((global.current_hit_points / size) * i > this.hit_points) c = 4;
    
    if(i == 0 && this.hit_points != 0) c = 0;
    else if(i == 0 && this.hit_points <= 0) c = 3;
    
    if(i == (size - 1) && this.hit_points == global.current_hit_points) c = 2;
    else if(i == (size - 1) && this.hit_points != global.current_hit_points) c = 5;
    
    draw_sprite_ext(spr_health_bar, c, 64 + (sprite_get_width(spr_health_bar) * scale * i), 64, scale, scale, 0, -1, 1);
}

draw_set_halign(fa_left);
draw_set_colour(c_black);
draw_text_transformed(875, 700, "Level : " + string(this.level), 0.5, 0.5, 0);
draw_text_transformed(875, 720, "Gold : " + string(ds_grid_get(this.inventory, 1, scr_grid_find_value(this.inventory, "gold"))), 0.5, 0.5, 0);
draw_text_transformed(875, 740, "Wave : " + string(global.wave), 0.5, 0.5, 0);

//scr_draw_string(875, 700, "Level : " + string(this.level), 2, fa_left, 1, -1);
//scr_draw_string(875, 720, "Gold : " + string(ds_grid_get(this.inventory, 1, scr_grid_find_value(this.inventory, "gold"))), 2, fa_left, 1, -1);
//scr_draw_string(875, 740, "Wave : " + string(global.wave), 2, fa_left, 1, -1);

sizeXP = 167;
for(var i = 0; i < sizeXP; i++) {
    
    var expr = ds_grid_get(this.inventory, 1, scr_grid_find_value(this.inventory, "experience"));
    var c;    

    if(((global.level_up * level) / sizeXP) * i <= expr) c = 1;
    else if(((global.level_up * level) / sizeXP) * i > expr) c = 4;
    
    if(i == 0 && expr != 0) c = 0;
    else if(i == 0 && expr <= 0) c = 3;
    
    if(i == (sizeXP - 1) && expr == (global.level_up * level)) c = 2;
    else if(i == (sizeXP - 1) && expr != (global.level_up * level)) c = 5;
    
    draw_sprite_ext(spr_health_bar, c, 10 + (sprite_get_width(spr_health_bar) * scale * i), 675, scale, scale, 0, -1, 1);
}

/////////////////////////////////////////////////////////////////////////

// Find out what weapons player has
ds_list_clear(this.current_items)
for(var o = hotbar_start; o < scr_grid_get_size(inventory, "height"); o++) {
    var item = ds_grid_get(inventory, 0, o);
    ds_list_add(current_items, ds_list_find_index(global.items, item));    
} 

// Gui for selected weapons on tool bar

for(var i = 0; i < 8; i++) {

    var c, color;
    
    if(i != item_selected) color = merge_colour(c_white, c_black, 0.5);
    else color = -1;
    
    if(ds_list_size(this.current_items) <= i) c = 0;
    else c = ds_list_find_value(this.current_items, i);

    scr_display_tab(250 + ((sprite_get_width(spr_skill_tabs) + 10) * scale * i), 700, c, scale, color);
}

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
        

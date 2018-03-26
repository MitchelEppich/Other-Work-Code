///scr_player_inventory_draw(id)
var this = argument0;

// Find out what weapons player has
ds_list_clear(this.current_items)
for(var o = hotbar_start; o < scr_grid_get_size(inventory, "height"); o++) {
    var item = ds_grid_get(inventory, 0, o);
    ds_list_add(current_items, ds_list_find_index(global.items, item));    
} 

// Gui for selected weapons on tool bar

for(var i = 0; i < 8; i++) {

    var index, color;
    var scale = 3.5;
    
    if(i != item_selected) color = merge_colour(c_white, c_black, 0.5);
    else color = -1;
    
    if(ds_list_size(this.current_items) <= i) index = 0;
    else index = ds_list_find_value(this.current_items, i);

    var xx = ceil(view_wport[0] * (1/6)) + ((sprite_get_width(spr_skill_tabs) + 10) * scale * i);
    var yy = 700;
    
    draw_sprite_ext(spr_skill_tabs, index, xx, yy, scale, scale, 0, color, 1);
    //scr_display_tab(250 + ((sprite_get_width(spr_skill_tabs) + 10) * scale * i), 700, c, scale, color);
}

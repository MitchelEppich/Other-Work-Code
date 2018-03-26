/// scr_scroll_box(this, optional_list, align, enable_bar, list_length)
var this = argument0;
var list;

if (argument1 == -1) list = this.item_list;
else list = argument1;

var len = ds_list_size(list);
var len_max = min(argument4, len);

this.selection = min( max (0, this.selection + (key_down - key_up)), len - 1);

var minCell = max (0, selection - len_max + 1);
if (minCell + len_max > len && len > len_max) minCell = len - len_max;
var maxCell = min( len, minCell + len_max);

var voffset = 60;
var maxCell_height = 59;

// Draw tabs
for (var i = minCell; i < maxCell; i++) {
    if (this.selection == i) color = make_color_rgb (176, 18, 10);
    else color = make_color_rgb (97, 97, 97);
    
    draw_set_font(font_main);
    draw_set_color(color);
    draw_set_halign(argument2);
    
    var value = ds_list_find_value(list, i);
    sprite_index = object_get_sprite(value);
    var identity;
    if (is_string(value) || sprite_index == -1) identity = value;
    else identity = string(object_get_name(value));
    
        draw_rectangle_color(x, (y + (i - minCell) * voffset), x + 224, (y + (i - minCell) * voffset) + maxCell_height, c_gray, c_gray, c_gray, c_gray, 0);
        draw_rectangle(x, (y + (i - minCell) * voffset), x + 210, (y + (i - minCell) * voffset) + (maxCell_height - 2), 0);
        //show_debug_message(sprite_index);
        if(sprite_index != -1) draw_sprite_ext(sprite_index, 0, x + 24, (y + (i - minCell) * voffset) + 50, 3 * ( 15 / sprite_width ), 3 * ( 14 / sprite_height ), 0, -1, 1); // 45 x 42
        draw_text_transformed_colour(x + 60, (y + (i - minCell) * voffset) + 26, identity, 0.5, 0.5, 0, c_white, c_white, c_white, c_white, 1);
    
    
    sprite_index = noone;
} 

// Draw Scroll Bar
if (argument3) {
    // Draw scroll bar
    var bar_len = maxCell_height + (voffset * (len_max - 1)) - ((len_max - 1) / 2);
    
    // Size bar
    bar_len *= len_max / len;
    
    // Bar Offset
    // 1 = 10, 3 = 20, 5 = 30, 7 = 40 ... 2 : 10, x > 10
    var bar_voffset = bar_len * (selection/ max(1, len - 1)) * (((len - (len_max * 2)) / len_max) + 1); 

    draw_rectangle(x + 212, y + 2 + bar_voffset, x + 222, y + bar_len + bar_voffset, 0); 
}

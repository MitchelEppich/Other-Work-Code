/// scr_list_draw(id, x, y, align)

// Create local list
var list = argument0;

// Create local positions
var xx = argument1;
var yy = argument2;

// Align text as specified
draw_set_halign(argument3);
draw_set_font(font_main);

var len = ds_list_size(list);

// Draw list elements
for (var i = 0; i < len; i++) {
    /*
        Element :
            
            text    
            scale
            sep
            color
            alpha
            
    */
    var base = 1;
    // Collect current element
    var el = ds_list_find_value(list, i);
    
    // Create local element variables
    var text = el[? "text"];
    var scale = el[? "scale"];
    var color = el[? "color"];
    var alpha = el[? "alpha"];
    var index = el[? "index"];
    
    // Hover
    if (selection != i && selection != -1 && len > 1) {
        alpha -= 0.8;
    }
    
    // Test if color is correct
    if (is_string(color)) {
        color = -1;
    }
    
    // Test for previous element
    
    // Create variables
    var xoffset = 0, yoffset = 0;
    
    if (i > 0) {
        // Collect previous element
        var prev_el = list[| i - 1];
        
        // Create local element variables
        xoffset = prev_el[? "xoffset"];
        yoffset = prev_el[? "yoffset"];
    }
    // Draw element
    xx += xoffset;
    yy += yoffset;

    if (is_string(text))
        draw_text_transformed_colour(xx, yy, text, scale, scale, 0, color, color, color, color, alpha);
    else // sep is used for subimage
        draw_sprite_ext(text, index, xx, yy, scale, scale, 0, color, alpha);
}

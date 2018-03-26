/// scr_list()

// get size of board //
var vw = view_wview[view_current];
var vh = view_hview[view_current];

// Set font //
draw_set_font(font0);

// Create list //
var el = ds_list_create();
ds_list_add(el, "Play", "New Game", "Quit");

// Set align //
draw_set_halign(fa_center);
draw_set_valign(fa_center);

// Set origin //
var xx = vw/2;
var yy = vh/2;

// Set Base offset //
var xoffset = 0;
var yoffset = 0;

// Draw list //
// Initialize variables
var xoff = 0;
var yoff = 0;

// Loop through elements
for (var i = 0; i < ds_list_size(el); i++) {

    // Get string
    var str = el[| i];
    
    // Set color
    var color = c_white;
    
    // Set alpha 
    var alpha = 1;
    
    // Set scale
    var xscale = 1;
    var yscale = 1;
    
    // Set angle
    var angle = 0;
    
    // Get string dimensions
    var width = string_width(str) * xscale;
    var height = string_height(str) * yscale;

    // Draw text
    draw_text_transformed_color(xx + xoff, yy + yoff, str, xscale, yscale, angle, color, color, color, color, alpha);

    // Update offset depending on text
    xoff += 0 + xoffset;
    yoff += height + yoffset;
}

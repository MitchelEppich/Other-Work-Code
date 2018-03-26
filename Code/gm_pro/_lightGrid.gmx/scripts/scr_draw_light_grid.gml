/// scr_draw_light_grid()

x = 0;
y = 0;
var w = room_width;
var h = room_height;

var rows = 3;
var cols = 3;

var row_h = h/rows;
var col_w = w/cols;

repeat(rows - 1) {
    var yy = row_h * --rows;
    draw_line(x, yy, w, yy);
}

repeat(cols - 1) {
    var xx = col_w * --cols;
    draw_line(xx, y, xx, h);
}

// Draw selection
xx = floor(mouse_x / col_w) * col_w;
yy = floor(mouse_y / row_h) * row_h;
draw_rectangle(xx, yy, xx + col_w, yy + row_h, false);

/// scr_dev_console ()
draw_set_font(font_main);


// Text Box
draw_set_color(c_white);
draw_rectangle(20 , 20, view_wport[0] - 20, 50, 0);

// Text
draw_set_color(c_black);
draw_set_halign(fa_left);
draw_text_transformed(30, 30, keyboard_string, 0.5, 0.5, 0);

if (key_enter) {
    command = keyboard_string;
    keyboard_string = "";
}

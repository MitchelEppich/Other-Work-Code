///scr_state_menu_draw()
draw_set_font(font_main);

draw_set_halign(fa_center);
draw_text_transformed(room_width/2, 100, "Prixed", 2, 2, 0);
draw_text_transformed(room_width/2, 160, "developed by", 0.6, 0.6, 0);
draw_text_transformed(room_width/2, 180, "BAREWARE GAMES", 1.4, 1.4, 0);

var colour = c_white;
var alpha = 0.5;

menu_items = 5;

if(menu_selection == 0) { colour = c_red; alpha = 1; } else { colour = c_white; alpha = 0.5; }
draw_text_transformed_colour(room_width/2, room_height*(16/24), "Play", 1, 1, 0, colour, colour, colour, colour, alpha);
if(menu_selection == 1) { colour = c_red; alpha = 1; } else { colour = c_white; alpha = 0.5; }
draw_text_transformed_colour(room_width/2, room_height*(17/24), "Test Zone", 1, 1, 0, colour, colour, colour, colour, alpha);
if(menu_selection == 2) { colour = c_red; alpha = 1; } else { colour = c_white; alpha = 0.5; }
draw_text_transformed_colour(room_width/2, room_height*(18/24), "Options", 1, 1, 0, colour, colour, colour, colour, alpha);
if(menu_selection == 3) { colour = c_red; alpha = 1; } else { colour = c_white; alpha = 0.5; }
draw_text_transformed_colour(room_width/2, room_height*(19/24), "Quit", 1, 1, 0, colour, colour, colour, colour, alpha);
if(menu_selection == 4) { colour = c_red; alpha = 1; } else { colour = c_white; alpha = 0.5; }
draw_text_transformed_colour(room_width/2, room_height*(23/24), "More...", 0.4, 0.4, 0, colour, colour, colour, colour, alpha);

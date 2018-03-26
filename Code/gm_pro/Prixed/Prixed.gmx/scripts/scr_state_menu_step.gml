///scr_state_menu_step()
if(keyboard_check_pressed(global.down)) {
    menu_selection++;
}

if(keyboard_check_pressed(global.up)) {
    menu_selection--;
}

if(menu_selection > menu_items - 1) {
    menu_selection = 0;
} else if(menu_selection < 0) {
    menu_selection = menu_items - 1;
}

if(keyboard_check_pressed(global.enter)) {
    switch(menu_selection) {
        case 0:
            room_goto(rm_sandbox);
            break;
        case 1:
            room_goto(rm_test);
            break;
        case 2:
            //room_goto(rm_options);
            break;
        case 3:
            game_end();
            break;
        case 4:
            url_open_ext(URL_COMPANY, '_blank');
            break;
    }
}

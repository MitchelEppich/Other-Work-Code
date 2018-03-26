/// scr_get_handler(text)

switch(argument0) {
    case "player":
        return global.player;
    case "keeper":
        return global.keeper;
    default:
        show_debug_message("Error : No Match <scr_get_handler> input=" + argument0);
}


/// scr_get_room_id(string)

switch (argument0){
    case "rm_newMenu":
        return rm_newMenu;
    case "rm_newlevelviewer":
        return rm_newlevelviewer;
    case "rm_newcharacter":
        return rm_newcharacter;
    case "rm_game_inventory":
        return rm_game_inventory;
    case "rm_game_store":
        return rm_game_store;
    case "rm_game":
        return rm_game;
    case "rm_game_store_sell":
        return rm_game_store_sell;
    default:
        show_debug_message("Error : No Match <scr_get_room_id> input=" + argument0);
        return rm_newMenu;
}

/// scr_set_preview(action)
var action = argument0;
show_debug_message(action);
var who = "", title = "", phrase = "";
while(string_copy(action, 1, 1) != '~') {
    phrase += string_copy(action, 1, 1);
    action = string_delete(action, 1, 1);
}

action = string_delete(action, 1, 1);

while(string_copy(action, 1, 1) != '~') {
    who += string_copy(action, 1, 1);
    action = string_delete(action, 1, 1);
}

action = string_delete(action, 1, 1);

title = action;

switch (who) {
    case "keeper":
        var map = global.keeper[? "preview"];
        break;
    case "player":
        var map = global.player[? "preview"];
        break;
    default:
        show_debug_message("Error : No one found to edit <scr_set_preview> Input : " + who);
        exit;
}

map[? "title"] = title;
map[? "phrase"] = phrase;

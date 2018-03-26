/// scr_quest_dest(action)

var action = argument0;

for (var i = 0; i < string_length(action); i++) {
    if (string_copy(action, 1, 1) != '<') 
        action = string_delete(action, 1, 1);
    else break;
}

action = string_copy(action, 2, string_length(action) - 2);

return action;

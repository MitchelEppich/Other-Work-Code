/// scr_list_step()

if (selection == -1) exit;
// Create a directional press variable
var dir = arrow_axis;

if (dir == "horizontal") dir = global.key[? "c_right"] - global.key[? "c_left"];
else dir = global.key[? "c_down"] - global.key[? "c_up"];

selection = min(max(0, selection + (dir)), ds_list_size(list) - 1);

var el = list[| selection];
var action = el[? "action"];
if (global.key[? "enter"] && real(action) != -1) {
if (el == undefined) exit;

    if (is_string(action)) {
        
        if (string_copy(action, 1, 2) == "->") {  
            scr_set_quest(action);
            room_goto(rm_game);
        }
    
        if (string_copy(action, 1, 7) == "place::") {
            
            // record room
            global.room_trail[| ds_list_size(global.room_trail)] = room;
        
            var rm = room_goto(rm_newcharacter);
            global.destination = string_copy(action, 8, string_length(action));
            exit;
        }
        
        if (is_quest(action)) {
            action = scr_quest_dest(action);
        }
        
        if (string_copy(action, 1, 6) == "goto::") {
        
            // record room
            global.room_trail[| ds_list_size(global.room_trail)] = room;
        
            action = string_delete(action, 1, 6);
            
            room_goto(scr_get_room_id(action));
        }
        
        if (string_copy(action, 1, 5) == "use::") {
            var index = real(string_copy(action, 6, string_length(action) - 5));
            scr_use_item(inv_ref[| index], index);
        }
        
        if (string_copy(action, 1, 9) == "dispose::") {
            var index = real(string_copy(action, 10, string_length(action) - 9));
            ds_list_delete(inv_ref, index);
        }
        
        if (string_copy(action, 1, 9) == "comment::") {
            show_debug_message("Error : comment attempt -> not initialized <scr_list_step> input=" + action);
        }
        
        if (string_copy(action, 1, 13) == "transaction::") {
            action = string_delete(action, 1, 13);
            scr_process_transaction(action);
        }
    }
    
    switch (action) {
        case "end":
            game_end();
            break;
        case "restart":
            game_restart();
            break;
    }
}

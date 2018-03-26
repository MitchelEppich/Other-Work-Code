/// scr_translate_action(action)

var decode = true;

// Create map for actions
var actions = ds_map_create();
ds_map_clear(actions);
// Create local copy of coded action
var action = argument0;

// Break down action
action = string_delete(action, 1, 5);
/*

'?' Kill command
':' Split 
'!' Start 

*/

var key = '', count = -1;

while (decode) {
    
    var letter = string_copy(action, 1, 1);
    
    if (letter == '?') {
        decode = false;
        action = string_delete(action, 1, 1);
            while (string_count('<', action) != 0) {
                action = string_delete(action, string_length(action), 1);
            }
        ds_map_add(actions, "dest", action);
        continue;
    }
    
    if (letter == ':') {
        // Move to action item
        key = "item" + string(count);
        ds_map_add(actions, key, "");
    } else if (letter == '!') {
        // Move to next action
        count++;
        key = "amount" + string(count);
        ds_map_add(actions, key, "");
    } else 
        ds_map_replace(actions, key, ds_map_find_value(actions, key) + string(letter));
    
    action = string_delete(action, 1, 1);

}

var q_amount = actions[? "amount0"]
var q_item = actions[? "item0"];
var q_dest = actions[? "dest"];

action = "Hey can you take " + string(q_amount) + " of these " + string(q_item) + " to the " + string(q_dest) + "?";

return action;

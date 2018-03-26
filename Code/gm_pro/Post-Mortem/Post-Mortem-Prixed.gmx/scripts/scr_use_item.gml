/// scr_use_item(item, index)

var el = argument0;

var p = global.player[? "body"];

if (el[? "usage"] == "consume") {
    // Consume
}
var prev = p[? el[? "usage"]];
show_debug_message(string(prev[? "name"]));
if (prev != 0) {
    prev[? "index"]--;
    ds_list_replace(inv_ref, argument1, prev);
} else ds_list_delete(inv_ref, argument1);

p[? el[? "usage"]] = el;

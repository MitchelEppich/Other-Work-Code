/// scr_guide_add(phrase, expression)
var p = global.guide[? "phrase"];
var e = global.guide[? "expression"];
var ed = global.guide[? "e_data"];

ds_queue_enqueue(p, argument0);
if (ed[? argument1] == undefined) ex = ed[? "calm"];
else ex = ed[? argument1];
ds_queue_enqueue(e, ex);

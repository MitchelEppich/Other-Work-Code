/// scr_player()
var equip = ds_map_create(); // equipted
equip[? "head"] = 0;
equip[? "torso"] = 0;
equip[? "back"] = 0;
equip[? "feet"] = 0;
equip[? "hand"] = 0;
equip[? "item"] = 0;
equip[? "arm"] = 0;
equip[? "leg"] = 0;

var detail = ds_map_create(); // detail
detail[? "name"] = "Mitchel";
detail[? "age"] = "6";
detail[? "rates"] = "2.43";
detail[? "scene"] = -1;

var prev = ds_map_create(); // preview
prev[? "title"] = "";
prev[? "phrase"] = "";

var inv = ds_list_create(); // inventory
inv[| 0] = scr_get_object(global.items, "shirt");

var inv_hold = ds_map_create(); // inventory holder
inv_hold[? "inventory"] = inv;
inv_hold[? "selection"] = 0;

var info = ds_list_create(); // info
info[| 0] = "";

var speech = ds_list_create(); // speech
speech[| 0] = "";

var body = ds_list_create(); // body bag
body[| 0] = obj_human_head;
body[| 1] = obj_human_torso;
body[| 2] = obj_human_arm;
body[| 3] = obj_human_arm;
body[| 4] = obj_human_foot;
body[| 5] = obj_human_foot;

var stat = ds_map_create(); // stats
stat[? "health"] = 10;
stat[? "energy"] = 10;
stat[? "skin_tone"] = SKIN_PEACH;
stat[? "dir"] = 0;
stat[? "face"] = RIGHT;
stat[? "team"] = "neutral";
stat[? "target"] = noone;
stat[? "sprite"] = spr_human;
stat[? "costume"] = -1;
stat[? "air"] = 1;
stat[? "alive"] = true;
stat[? "speed"] = 2;
stat[? "jump_force"] = 7 * 2.4;
stat[? "fixed_rotation"] = true;
stat[? "grounded"] = false;

var task = "No Recent Task.";

var pack = ds_map_create(); // package
pack[? "package"] = noone;
pack[? "joint"] = -1;

var map = ds_map_create(); // map
map[? "info"] = info;
map[? "inv_holder"] = inv_hold;
map[? "speech"] = speech;
map[? "detail"] = detail;
map[? "preview"] = prev;
map[? "body"] = equip;
map[? "package"] = pack;
map[? "stat"] = stat;
map[? "body"] = body;
map[? "task"] = task;


return map;

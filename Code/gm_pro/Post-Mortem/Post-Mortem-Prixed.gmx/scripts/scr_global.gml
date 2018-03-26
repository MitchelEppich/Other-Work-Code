/// scr_global()
global.pause = false;
global.mute = false;

global.room_trail = ds_list_create();

// Databases
scr_input();
scr_tiledb();
scr_itemdb();
scr_destdb();
scr_towndb();

// Ingame global
global.player = scr_player();
global.keeper = 0;
global.guide = scr_guide();
global.respawn = 0;
global.destination = 0;
global.town = global.town[? "reville"];

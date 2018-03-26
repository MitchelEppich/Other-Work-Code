global.paused = false;
global.sprite = -1;

global.base_mass = 50;

global.tick = 0;
global.start_tick = 0;

global.base_walk_speed = 1;
global.base_run_speed = 6;
global.max_speed = 10;

// for tracking position
global.player = -1;

// For player
global.current_hit_points = 0;
global.level_up = 50;

// Wave Games
global.wave = 1;

global.spawn_tick = 0;
global.char_to_spawn = 0;
global.char_count = 0;

global.current_wave = global.wave - 1;

global.display = false;

//Current weapons in game
global.items = ds_list_create();
ds_list_add(global.items,
"",
"fireball",
"stab",
"teleport",
"javelin",
"arrow",
"punch",
"hack",
"heal",
"regenerate",
"harden",
"slash",
"beam",
"gold",
"experience"
);

// Shops in game
global.shops = ds_list_create();
ds_list_add(global.shops,
"armoury",
"hospital",
"magic"
);

//Input Control
globalvar FONT;
FONT = font_add_sprite(spr_font, ord(" "), false, 2);
draw_set_font(FONT);

//weapon presets
global.item_preset = ds_grid_create(3, 64);

ds_grid_add(global.item_preset, 0, 0, "punch");
ds_grid_add(global.item_preset, 1, 0, -1);
ds_grid_add(global.item_preset, 2, 0, 0);

ds_grid_add(global.item_preset, 0, 1, "stab");
ds_grid_add(global.item_preset, 1, 1, 50);
ds_grid_add(global.item_preset, 2, 1, 0.2);

ds_grid_add(global.item_preset, 0, 2, "hack");
ds_grid_add(global.item_preset, 1, 2, 50);
ds_grid_add(global.item_preset, 2, 2, 2.3);

ds_grid_add(global.item_preset, 0, 3, "fireball");
ds_grid_add(global.item_preset, 1, 3, 50);
ds_grid_add(global.item_preset, 2, 3, 1.8);

ds_grid_add(global.item_preset, 0, 4, "arrow");
ds_grid_add(global.item_preset, 1, 4, 200);
ds_grid_add(global.item_preset, 2, 4, 0.8);

ds_grid_add(global.item_preset, 0, 5, "teleport");
ds_grid_add(global.item_preset, 1, 5, 5);
ds_grid_add(global.item_preset, 2, 5, 75);

ds_grid_add(global.item_preset, 0, 6, "javelin");
ds_grid_add(global.item_preset, 1, 6, 50);
ds_grid_add(global.item_preset, 2, 6, 1.6);

ds_grid_add(global.item_preset, 0, 7, "slash");
ds_grid_add(global.item_preset, 1, 7, 50);
ds_grid_add(global.item_preset, 2, 7, 0.4);

ds_grid_add(global.item_preset, 0, 8, "beam");
ds_grid_add(global.item_preset, 1, 8, 100);
ds_grid_add(global.item_preset, 2, 8, 0.1);

ds_grid_add(global.item_preset, 0, 9, "heal");
ds_grid_add(global.item_preset, 1, 9, 5);
ds_grid_add(global.item_preset, 2, 9, 5);

ds_grid_add(global.item_preset, 0, 10, "regenerate");
ds_grid_add(global.item_preset, 1, 10, 1);
ds_grid_add(global.item_preset, 2, 10, 100);

ds_grid_add(global.item_preset, 0, 11, "harden");
ds_grid_add(global.item_preset, 1, 11, 1);
ds_grid_add(global.item_preset, 2, 11, 150);

///scr_handler_waves()
// Tracks characters left to spawn
if(global.char_to_spawn == 0) {
    global.spawn_tick = 40 - (floor(random_range(2, 5)) * global.wave);
    global.char_to_spawn = 1 * floor(random_range(2, 5)) * global.wave;
    global.char_count = 0;
}

// Get stats 
var spawn = ds_map_find_value(global.game_total, "enemy_spawn");
var death = ds_map_find_value(global.game_total, "enemy_death");

// Spawn enemies if needed
if(global.tick mod global.spawn_tick == 0 && global.char_count <= global.char_to_spawn && (spawn - death) < 10) {
    scr_handler_spawner(choose("zombie", "tank", "midget"));
    global.char_count++;
}

// Prepare next wave and spawn helpers
if(global.char_count >= global.char_to_spawn && spawn == death) { 
    global.wave++;
    global.char_count = 0;
    global.char_to_spawn *= floor(random_range(2, 5)) * global.wave;
    global.spawn_tick -= global.wave;
    if(global.spawn_tick < 5) global.spawn_tick = 5;
    scr_create_soldier(random_range(0, room_width), 0);
}

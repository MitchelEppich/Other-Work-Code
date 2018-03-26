// GAME MAP
global.game_total = ds_map_create();

// Game Totals
ds_map_add(global.game_total, "game_kill", 0);
ds_map_add(global.game_total, "game_spawn", 0);
ds_map_add(global.game_total, "game_death", 0);
ds_map_add(global.game_total, "game_damage", 0);
ds_map_add(global.game_total, "game_energy", 0);
ds_map_add(global.game_total, "game_distance", 0);
ds_map_add(global.game_total, "game_coin", 0);

// Game Progress
ds_map_add(global.game_total, "game_quest", 0);
ds_map_add(global.game_total, "game_achievement", 0);

// Player Totals
ds_map_add(global.game_total, "player_kill", 0);
ds_map_add(global.game_total, "player_spawn", 0);
ds_map_add(global.game_total, "player_death", 0);
ds_map_add(global.game_total, "player_damage", 0);
ds_map_add(global.game_total, "player_energy", 0);
ds_map_add(global.game_total, "player_distance", 0);
ds_map_add(global.game_total, "player_coin", 0);

// Friend Totals
ds_map_add(global.game_total, "friend_kill", 0);
ds_map_add(global.game_total, "friend_spawn", 0);
ds_map_add(global.game_total, "friend_death", 0);
ds_map_add(global.game_total, "friend_damage", 0);
ds_map_add(global.game_total, "friend_energy", 0);
ds_map_add(global.game_total, "friend_distance", 0);
ds_map_add(global.game_total, "friend_coin", 0);

// Enemy Totals
ds_map_add(global.game_total, "enemy_kill", 0);
ds_map_add(global.game_total, "enemy_spawn", 0);
ds_map_add(global.game_total, "enemy_death", 0);
ds_map_add(global.game_total, "enemy_damage", 0);
ds_map_add(global.game_total, "enemy_energy", 0);
ds_map_add(global.game_total, "enemy_distance", 0);
ds_map_add(global.game_total, "enemy_coin", 0);

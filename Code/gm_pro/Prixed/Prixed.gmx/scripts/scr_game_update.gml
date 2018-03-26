///scr_game_update()

if(global.tick > 2000) global.tick = 0;
else global.tick++;

if(instance_exists(obj_shop)) global.paused = true;
    
if(!global.paused) {
    if(global.player == -1 && room_get_name(room) != "rm_menu") scr_handler_spawner("player");
    if(room_get_name(room) != "rm_test") {
        scr_collectable_spawner();
        scr_handler_waves();
    }
}

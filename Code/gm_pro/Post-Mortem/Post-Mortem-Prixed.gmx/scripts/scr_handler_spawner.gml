var type = argument0;
var inst;

switch(type) {
    case "zombie":
    scr_create_zombie(random_range(0, room_width), 0);
    break;
    case "tank":
    scr_create_tank(random_range(0, room_width), 0);
    break;
    case "player":
    scr_create_player(random_range(0, room_width), 0);
    break;  
    case "midget":
    scr_create_midget(random_range(0, room_width), 0);
    break;  
}

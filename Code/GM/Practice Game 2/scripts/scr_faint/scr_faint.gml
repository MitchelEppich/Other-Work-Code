scr_sleep();
var loc = global.bedRef;
instance_move(loc.x, loc.y, global.playerRef);
show_message("You fainted... Get better.");
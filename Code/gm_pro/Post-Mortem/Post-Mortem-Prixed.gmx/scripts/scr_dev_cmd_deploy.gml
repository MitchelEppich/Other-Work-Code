/// scr_dev_cmd_deploy (type)

switch (argument0) {
// Restart
case "restart":
game_restart();
break;
// Quit
case "quit":
game_end();
break;
// Default
default:
unknown = true;
break;
}

if(unknown) return 0;

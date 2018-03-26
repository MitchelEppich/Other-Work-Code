var whois = argument0;
var deploy = argument1;

if(deploy) {
    var inst = global.player;
    scr_handler_tamper_deploy_controller(whois, inst, scr_tamper_other(-100, 10, "harden"));
} else {
    scr_weapon_controller(whois, whois, 2, 250, 10, -1, 1, 1, "");
}

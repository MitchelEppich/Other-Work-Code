///scr_melee_punch(id, target, deploy)
var whois = argument0;
var target = argument1;
var deploy = argument2;

if(deploy) {
    if(whois.targeted != noone)
        scr_handler_tamper_deploy_controller(whois, target, scr_tamper_other(3, -1, "punch"));
} else {
    scr_weapon_controller(whois, whois, 2, 15, 0, -1, 1, 0, "");
}

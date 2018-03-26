var whois = argument0;
var inst = scr_create_ghost(whois.x, whois.y, whois);
inst.alarm[0] = 5 * room_speed;

global.paused = true;

var tampering_damage = argument0;
var tampering_duration = argument1;

if(tampering_damage == -1) tampering_damage = 0;
if(tampering_duration == -1) tampering_duration = 1;

var tampering = argument2;
var tampering_contagious = 0;
var tampering_delay = 10;

var str;
str = tampering + "," + string(tampering_damage) + "," + string(tampering_duration) + "," + string(tampering_contagious) + "," + string(tampering_delay)

return str;

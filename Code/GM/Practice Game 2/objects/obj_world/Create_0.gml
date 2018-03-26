/// @description Insert description here
// You can write your code in this editor
global.day = 0;
global.time = 0;

global.morningTime = 39;
global.eveningTime = 72;
global.nightTime = 12;

global.oneDay = 144;
global.halfDay = global.oneDay / 2;

global.tickPerMin = room_speed;
global.minInHour = 6;

global.playerRef = instance_create_layer(500, 400, "Instances", obj_player);
global.bedRef = instance_create_layer(400, 400, "Instances", obj_bed);

// Start day timer
alarm[0] = global.tickPerMin;

// Set intial time of day
global.time = global.morningTime;

// Create the day nigh affect
a = 0;
fade = (1 / 72);
a_clamp_low = 0;
a_clamp_high = 0.70;
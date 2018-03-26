// Fade screen out
instance_create_layer(0, 0, "Overlay", obj_fade);

// Check if player slept in time
var wellSlept = (global.time <= global.nightTime);

// Increment the day
global.day++;

// Set time of new day
if wellSlept 
	global.time = global.morningTime;
else
	global.time = global.eveningTime;
/// @description Insert description here
// You can write your code in this editor
// Check if past midnight
if global.time >= global.oneDay global.time = 0;

// Day night cycle step
if global.time > global.eveningTime && global.time < global.oneDay 
	a = fade * (global.time - global.halfDay); 
else 
	a = fade * (global.halfDay - global.time);

a = a * (a_clamp_high - a_clamp_low);
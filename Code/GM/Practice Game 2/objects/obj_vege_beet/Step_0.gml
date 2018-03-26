/// @description Insert description here

//// Growth
// How many frames for the plant
var frames = image_number - 1;

// How many days are elapsed
var days_elapsed = global.day - day_planted;

// Percentage completed
var growth_percent = clamp(days_elapsed / days_of_growth, 0, 1);

// Set image frame
image_index = frames * growth_percent;

// Set if this item is harvestable
if growth_percent == 1 is_harvestable = true;
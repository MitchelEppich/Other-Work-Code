/// @description Insert description here
// You can write your code in this editor
image_speed = 0;

var right = position_meeting(x + sprite_width/2, y, oWall);
var left = position_meeting(x - sprite_width/2, y, oWall);
var top = position_meeting(x, y - sprite_height/2, oWall);
var bottom = position_meeting(x, y + sprite_height/2, oWall);

if(right and left and top and bottom) { image_index = 15; exit; }
else if(right and left and top) { image_index = 14; exit; }
else if(right and left and bottom) { image_index = 12; exit; }
else if(top and bottom and right) { image_index = 11; exit; }
else if(top and bottom and left) { image_index = 13; exit; }
else if(top and bottom) { image_index = 5; exit; }
else if(top and right) { image_index = 10; exit; }
else if(top and left) { image_index = 9; exit; }
else if(bottom and right) { image_index = 7; exit; }
else if(bottom and left) { image_index = 8; exit; }
else if(right and left) { image_index = 6; exit; }
else if(right) { image_index = 1; exit; }
else if(left) { image_index = 3; exit; }
else if(top) { image_index = 4; exit; }
else if(bottom) { image_index = 2; exit; }
else { image_index = 0; }
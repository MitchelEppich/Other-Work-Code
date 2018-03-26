/// @description Insert description here
// You can write your code in this editor

event_inherited();

if(hunger < 100 and alarm[0] < 0) alarm[0] = room_speed;
if(anger < 100 and hunger >= 100 and alarm[1] < 0) alarm[1] = room_speed;

if(hunger == 0 and anger == 0) { image_index = 0; }
if(hunger > 30) image_index = 1;
if(hunger > 60) image_index = 2;
if(anger >= 20) image_index = 4;
if(hunger >= 100) image_index = 3;
if(anger > 50) image_index = 5;
if(anger > 80) image_index = 6;
if(anger >= 100 and hunger >= 100) image_index = 7;
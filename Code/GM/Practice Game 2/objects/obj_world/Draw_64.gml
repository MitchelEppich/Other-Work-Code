/// @description Insert description here
// You can write your code in this editor

// Design time of day
var m = [ "AM", "PM" ];
var mInd = 2;
var time = global.time;
var minu = (time % 6); //round(time / 100);
var hour = time - minu; //abs(time - (hour * 100));
if hour > 77 // 72 + 6 - 1 
{
	hour -= 72;
	mInd += 1;
}

if hour == 0 hour = 12;

if (time >= 0 && time < global.morningTime) draw_set_color(c_red);
else draw_set_color(c_black);
draw_text(10, 10, string(round(hour / 6)) + ":" + string(minu) + "0 " + m[mInd % 2])
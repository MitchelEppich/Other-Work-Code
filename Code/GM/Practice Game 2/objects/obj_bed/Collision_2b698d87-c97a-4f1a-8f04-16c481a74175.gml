/// @description Insert description here
// You can write your code in this editor
if keyboard_check_pressed(ord("S")) && canSleep 
{
	canSleep = false;
	scr_sleep();	
}
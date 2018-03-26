/// @description Insert description here
// You can write your code in this editor
a = clamp(a + (fade * 0.05), 0, 2);

// Fade in then out
if a == 2
	fade = -1;

if fade == -1 && a == 0
	instance_destroy();

draw_set_color(c_black);
draw_set_alpha(a);
draw_rectangle(
	view_xport[0],
	view_yport[0],
	view_xport[0] + view_wport[0],
	view_yport[0] + view_hport[0],
	0
);
draw_set_alpha(1);
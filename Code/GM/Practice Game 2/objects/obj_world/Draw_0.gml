/// @description Insert description here
// You can write your code in this editor
draw_set_color(make_color_rgb(0, 0.2, 0.4));
draw_set_alpha(clamp(a, a_clamp_low, a_clamp_high));
draw_rectangle(
	view_xport[0],
	view_yport[0],
	view_xport[0] + view_wport[0],
	view_yport[0] + view_hport[0],
	0
);
draw_set_alpha(1);
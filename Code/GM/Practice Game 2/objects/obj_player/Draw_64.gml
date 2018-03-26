/// @description Insert description here
// You can write your code in this editor
for (i = 0; i < ds_list_size(inventory); i++) 
{
	if inv_index == i draw_set_color(c_red);
	draw_text(10, 10 + 15 * i, string(i) + ") " + inventory[| i])	
	draw_set_color(c_black);
}
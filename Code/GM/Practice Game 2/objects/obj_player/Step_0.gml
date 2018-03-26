/// @description Movement script
// Move player
hspeed = (key_forward - key_backward) * move_speed;

// Place block where mouse clicks
if mouse_check_button_pressed(mb_left) {
	var tile = instance_create_layer(mouse_x, mouse_y, "House_Tiles", obj_wall_basic);
	with tile {
		move_snap(16, 16);	
	}
}

// Use current item
if keyboard_check_pressed(ord("F")) scr_useItem(inventory, inv_index);
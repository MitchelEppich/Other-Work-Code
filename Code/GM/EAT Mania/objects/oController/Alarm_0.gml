/// @description Insert description here
// You can write your code in this editor

repeat(10) 
{
	var xx = irandom_range(50, room_width - 50);
    var yy = irandom_range(50, room_height - 50);
	instance_create_layer(xx, yy, "Instances", oCustomer);
}
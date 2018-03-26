/// @description Insert description here
// You can write your code in this editor
image_yscale = clamp(image_yscale - 0.01, 0, 1);

if image_yscale == 0
{
	instance_create_layer(x, y, "Instances", object);
	instance_destroy();
}
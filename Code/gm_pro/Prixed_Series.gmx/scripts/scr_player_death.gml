/// scr_player_roll()

var sprite = spr_human_death;
var weapon_sprite = spr_knife_death;

if (sprite_index != sprite) sprite_index = sprite;
if (weapon_sprite_index != weapon_sprite) weapon_sprite_index = weapon_sprite;

image_speed = 0.1;

if (image_index > 5)
{
    image_speed = 0.3;
}

if (image_index >= image_number - 1) 
{
    image_speed = 0;   
}

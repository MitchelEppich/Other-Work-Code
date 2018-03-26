/// scr_player_roll()

var sprite = spr_human_roll;
var weapon_sprite = spr_knife_roll;

if (sprite_index != sprite) sprite_index = sprite;
if (weapon_sprite_index != weapon_sprite) weapon_sprite_index = weapon_sprite;

image_speed = 0.3;

if (abs(hsp) > 0) x_scale = sign(hsp);

master_spd *= 1.5;

if (image_index >= image_number - 1) rolling = false;

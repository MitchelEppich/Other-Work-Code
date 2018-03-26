/// scr_player_stun()

var sprite = spr_human_stun;
var weapon_sprite = spr_knife_stun;

if (sprite_index != sprite) sprite_index = sprite;
if (weapon_sprite_index != weapon_sprite) weapon_sprite_index = weapon_sprite;

image_speed = 0.2;

hsp = 0;

scr_shake_screen(1, 0.2);

if (abs(hsp) > 0) x_scale = sign(hsp);

/// scr_player_stealth_stand()

var sprite = spr_human_stealth_stand;
var weapon_sprite = spr_knife_stealth_stand;

if (sprite_index != sprite) sprite_index = sprite;
if (weapon_sprite_index != weapon_sprite) weapon_sprite_index = weapon_sprite;

if (abs(hsp) > 0) x_scale = sign(hsp);

alpha = 0.5;

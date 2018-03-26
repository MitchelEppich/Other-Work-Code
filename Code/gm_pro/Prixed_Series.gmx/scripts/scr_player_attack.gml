/// scr_player_attack()

var sprite = spr_human_punch;
var weapon_sprite = spr_knife_punch;

if (sprite_index != sprite) sprite_index = sprite;
if (weapon_sprite_index != weapon_sprite) weapon_sprite_index = weapon_sprite;

image_speed = 0.3;

if (abs(hsp) > 0) x_scale = sign(hsp);

if (image_index >= 4 and !damage_dealt)
{
    var inst = instance_create(x, y, obj_damage_box);
    inst._creator = id;
    
    damage_dealt = true;
}

if (image_index >= image_number - 1) 
{
    attacking = false;
    damage_dealt = false;
}

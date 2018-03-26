var whois = argument0;
var deploy = argument1;

if(deploy) {
    var inst = instance_create(whois.x + (30 * whois.dir), whois.y - (whois.sprite_height / 4), obj_projectile);
    with inst {
        scr_col_fireball(id);
        scr_weapon_controller(id, argument0, 10, 250, 8, -1, 1, 1, "fireball");
        sprite_index = spr_cast_fireball;
    }
    inst.dir = whois.dir;
} else {
    scr_weapon_controller(whois, whois, 2, 250, 10, -1, 1, 1, "");
}

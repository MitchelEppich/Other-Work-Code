///scr_range_javelin(id, deploy)
var whois = argument0;
var deploy = argument1;

if(deploy) {
    var inst = instance_create(whois.x + (30 * whois.dir), whois.y - (whois.sprite_height / 3), obj_projectile);
    with inst {
        scr_col_arrow(id);
        scr_weapon_controller(id, argument0, 2, 250, 10, -1, 1, 1, "");
        sprite_index = spr_javelin;
    }
    inst.dir = whois.dir;
    inst.creator = whois;
} else {
    scr_weapon_controller(whois, whois, 2, 250, 10, -1, 1, 1, "");
}

var this = argument0;

this.swimming = false;

var inst = instance_place(this.x, this.y, obj_terrain);
if(inst != noone) {
    var type = string_delete(object_get_name(inst.object_index), 1, 4);
    switch(type) {
        case "grass":
            scr_grass(this);
            break;
        case "gravel":
            scr_gravel(this);
            break;
        case "sand":
            scr_sand(this);
            break;
        case "stone":
            scr_stone(this);
            break;
        case "water":
            scr_water(this);
            this.swimming = true;
            break;
        case "dirt":
            scr_dirt(this);
            break;
    }
}

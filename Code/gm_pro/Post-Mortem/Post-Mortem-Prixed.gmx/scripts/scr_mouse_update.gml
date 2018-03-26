x = mouse_x;
y = mouse_y;

var this = argument0;

switch(this.tamper) {
    case "ignite":
        scr_part_spark();
        break;
    case "teleport":
        scr_part_teleport();
        break;
}

this.target = instance_place(x, y, obj_npc);

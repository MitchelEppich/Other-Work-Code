/// scr_load_room()
var file, n0, n1, inst, xx, yy;

file = get_open_filename("*.*", "savefile.ini");

inst_num = instance_number(obj_tile);

while inst_num > 0 {
    inst = instance_find(obj_tile, inst_num-1);
    with inst instance_destroy();
    inst_num-=1;
}

inst_num = instance_number(obj_instance);

while inst_num > 0 {
    inst = instance_find(obj_instance, inst_num-1);
    with inst instance_destroy();
    inst_num-=1;
}

ini_open(file);

n0 = 0;
n1 = 0;
inst = 0;
xx = 0;
yy = 0;

global.respawn = ini_read_real("GLOBAL", string(n0)+string(n1), 0); 

while ini_key_exists("TILE_MAP", string(n0)+string(n1)) {
    inst = ini_read_real("TILE_MAP", string(n0)+string(n1), 0);
    n1+=1;
    xx = ini_read_real("TILE_MAP", string(n0)+string(n1), 0);
    n1+=1;
    yy = ini_read_real("TILE_MAP", string(n0)+string(n1), 0);
    inst = instance_create(xx, yy, inst);
    
    n1+=1;
    inst.image_xscale = ini_read_real("TILE_MAP", string(n0)+string(n1), 0);
    
    if (object_get_name(inst.object_index) == "obj_tile_sign") {
        n1+=1;
        inst.text = ini_read_string("TILE_MAP", string(n0)+string(n1), 0);
        n1+=1;
        inst.expression = ini_read_string("TILE_MAP", string(n0)+string(n1), 0); 
    }
    n0+=1;
    n1 = 0;
}


ini_close();

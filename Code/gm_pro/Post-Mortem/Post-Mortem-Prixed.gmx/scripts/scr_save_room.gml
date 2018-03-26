///  scr_save_room()
show_debug_message("saving");
var file, inst_num, n0, n1, inst;
file = get_save_filename("*.*", "savefile.ini");
if (file_exists(file)) {
    file_delete(file);
} 

ini_open(file);

inst_num = instance_number(obj_tile);
n0 = 0;
n1 = 0;

while inst_num > 0 {
    inst = instance_find(obj_tile, inst_num-1);
    ini_write_real("TILE_MAP", string(n0) + string(n1), inst.object_index);
    n1+=1;
    
    ini_write_real("TILE_MAP", string(n0) + string(n1), inst.x);
    n1+=1;
    ini_write_real("TILE_MAP", string(n0) + string(n1), inst.y);
    n1+=1;
    
    ini_write_real("TILE_MAP", string(n0) + string(n1), inst.image_xscale);
    if (object_get_name(inst.object_index) == "obj_tile_sign") {
        n1+=1;
        ini_write_string("TILE_MAP", string(n0) + string(n1), inst.text);
        n1+=1;
        ini_write_string("TILE_MAP", string(n0) + string(n1), inst.expression);  
    }
    
    inst_num-=1;
    n0+=1;
    n1=0;
}
n0 = 0;
n1 = 0;
ini_write_real("GLOBAL", string(n0) + string(n1), global.respawn); 

ini_close();

if file_exists(file) {
    show_message_async("ROOM SAVED");
}

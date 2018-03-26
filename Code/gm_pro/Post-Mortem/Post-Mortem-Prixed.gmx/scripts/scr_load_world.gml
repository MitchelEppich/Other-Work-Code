/// scr_save_world()
var dir = working_directory + "\map";

if (!directory_exists(dir)) {
    directory_create(dir);
    show_message_async("Error : No directory for world saves!");
    exit;
}

var file = dir + "\" + "test.ini"//global.destination[? "name"] + ".ini";

if (!file_exists(file)) {
    show_message_async("Error : No file exists for this world!");
    exit;
}

var type = obj_tile;
var header;
var inst_num, n0, n1, inst;
inst_num = instance_number(type);

while (inst_num > 0) {
    inst = instance_find(obj_tile, inst_num--);
    with inst instance_destroy();
}   

ini_open(file);

n0 = 0; 
n1 = 0;

header = "GLOBAL_VAR";
global.respawn = ini_read_real(header, string(n0) + string(n1++), 0);

n0 = 0;
n1 = 0;

header = "TILE_MAP";

while (ini_key_exists(header, string(n0) + string(n1))) {
    inst = ini_read_real(header, string(n0) + string(n1++), 0);
    
    inst = instance_create(0, 0, inst);
    
    inst.x = ini_read_real(header, string(n0) + string(n1++), 0);
    inst.y = ini_read_real(header, string(n0) + string(n1++), 0);
    inst.image_xscale = ini_read_real(header, string(n0) + string(n1++), 0);
    
    if (!is_undefined(inst.text)) 
        inst.text = ini_read_real(header, string(n0) + string(n1++), 0);
        
    if (!is_undefined(inst.expression)) 
        inst.expression = ini_read_real(header, string(n0) + string(n1++), 0);
        
    n1 = 0;
    n0++;
}

ini_close();

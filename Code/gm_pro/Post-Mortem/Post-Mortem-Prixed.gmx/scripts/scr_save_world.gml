/// scr_save_world()
var dir = working_directory + "\map";

if (!directory_exists(dir)) {
    directory_create(dir);
}

var file = dir + "\" + global.destination[? "-ID"] + ".ini";

if (file_exists(file)) {
    file_delete(file);
}

ini_open(file);

var type = obj_tile;
var header = "TILE_MAP";
var inst_num, n0, n1, inst;
inst_num = instance_number(type);
n0 = 0; 
n1 = 0;

while inst_num > 0 {
    inst = instance_find(type, inst_num-- - 1);
    ini_write_real(header, string(n0) + string(n1++), inst.object_index);
    ini_write_real(header, string(n0) + string(n1++), inst.x);
    ini_write_real(header, string(n0) + string(n1++), inst.y);
    ini_write_real(header, string(n0) + string(n1++), inst.image_xscale);
    
    var text = true;
    with inst if (text == undefined) text = false;
    if (text) ini_write_string(header, string(n0) + string(n1++), inst.text);
      
    var expr = true;
    with inst if (expression == undefined) expr = false;  
    if (expr) ini_write_string(header, string(n0) + string(n1++), inst.expression);
        
    n1 = 0;
    n0++;
}

n0 = 0;
n1 = 0;

header = "GLOBAL_VAR"

ini_write_real(header, string(n0) + string(n1++), global.respawn);

ini_close();

if (!file_exists(file)) {
    show_message_async("Error :  World save was not successful!");
}

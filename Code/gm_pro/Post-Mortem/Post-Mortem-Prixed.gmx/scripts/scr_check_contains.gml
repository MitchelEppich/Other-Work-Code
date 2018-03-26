var who = argument0;
var check = argument1;

var size = ds_list_size(who.tampers);
var num = string_pos(",", check);
var str = string_copy(check, 1, num - 1);

for(i = 0; i < size; i++) {
    if(string_pos(str, ds_list_find_value(who.tampers, i)) != 0) {  
        return true;
    }
}
//if(string_pos(who.tampers, ds_list_find_value(str, 0)) != 0) {  
//    return true;
//}

return false;

///scr_get_input(letter)
var letter = argument0;
letter = string_upper(letter);
var list = scr_split_string(letter, "", 0);

var count = 0;
var pos = "";

while(count < ds_list_size(list)) {
    for(i = 0; i < array_length_1d(global.alpha); i++) {
        if(ds_list_find_value(list, count) == global.alpha[i]) {
            pos += string(i) + ",";
            count++;
            i = 0;
        }
    }
}

return pos;

var this = argument0;

var size = ds_list_size(this.tampers);
var track_loops = 0;

for(i = 0; i < size; i++) {
    track_loops++;
    if(track_loops>size) exit;

    //var current_tamper = this.tampers;
    var current_tamper = ds_list_find_value(this.tampers, i);
    var tamper_details = scr_split_string(current_tamper, ",", 0);
    
    var arr;
    arr[0] = "1";

    for(s = 0; s < ds_list_size(tamper_details); s++) {
        arr[s] = ds_list_find_value(tamper_details, s);
    }
    
    if(array_length_1d(arr) < 4) exit;
        //continue;
    scr_display_tamper(arr[0]);
    
    // tamper = 0; damage = 1; duration = 2;
    // contagious = 3; delay = 4;

    if(real(arr[2]) > 0 && global.tick mod real(arr[4]) == 0) {
        this.hit_points -= real(arr[1]);
        
        arr[2] = real(arr[2]) - 1;
        
        if(arr[3] == "1") scr_handler_tamper_contraction_controller(this, current_tamper);
        
        var str = string(arr[0]) + "," + string(arr[1]) + "," + string(arr[2]) + "," + string(arr[3]) + "," + string(arr[4]);
        //this.tampers = str;
        ds_list_replace(tampers, i, str);
        
    } else if(real(arr[2]) <= 0) {
        //this.tampers = "";
        ds_list_delete(tampers, i);
    }
}

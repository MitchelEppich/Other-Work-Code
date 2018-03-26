///scr_state_sandbow_step()
if(global.current_wave != global.wave || global.display) {
    global.current_wave = global.wave;
    var str = "Wave " + string(global.wave);

    scr_draw_string(room_width/2, room_height/2, str, 4, 0, 1, -1);
    
    global.display = true;
    if(alarm[0] <= 0)
        alarm[0] = 30;
}   

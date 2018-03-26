///scr_move_state
scr_get_input();

//Get the axis
//Once controller is fixed this can go!
xaxis = (right_key - left_key);
yaxis = (down_key - up_key);

//To dash state
if(dash_key) {
    // Player Sound
    audio_play_sound(dash, 1, 0);
    //Edit stamina
    stamina--;
    state = scr_dash_state;
    alarm[0] = room_speed / 6;
}

//To attack state
if(attack_key) {
    image_index = 0;
    // Player Sound
    audio_play_sound(strike, 1, 0);
    state = scr_attack_state;
}

//Get direction
dir = point_direction(0, 0, xaxis, yaxis);

//Get length
if(xaxis == 0 && yaxis == 0) {
    len = 0;
} else {
    scr_get_face();
    len = spd;
}

//Get hspd and vspd
hspd = lengthdir_x(len, dir);
vspd = lengthdir_y(len, dir);

//Move
// Horizontal collisions
if(scr_grid_place_meeting(x + hspd, y)) {
    while(!scr_grid_place_meeting(x + sign(hspd), y)) {
        x += sign(hspd);
    }
    hspd = 0;
}
phy_position_x += hspd;


// Vertical collisions
if(scr_grid_place_meeting(x, y + vspd)) {
    while(!scr_grid_place_meeting(x, y + sign(vspd))) {
        y += sign(vspd);
    }
    vspd = 0;
}
phy_position_y += vspd;

//Control sprite
image_speed = 0.2;
if(len == 0) image_index = 0;

switch(face) {
    case RIGHT:
        sprite_index = spr_player_right;
        break;
    case LEFT:
        sprite_index = spr_player_left;
        break;
    case UP:
        sprite_index = spr_player_up;
        break;
    case DOWN:
        sprite_index = spr_player_down;
        break;
}

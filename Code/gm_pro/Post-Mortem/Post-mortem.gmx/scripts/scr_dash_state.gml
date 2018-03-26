///scr_dash_state

//Get the axis
//Once controller is fixed this can go!
xaxis = (right_key - left_key);
yaxis = (down_key - up_key);

//Set length
if(len == 0)
    dir = face * 90;
len = spd * 2; // Dash will move 4 times as fast

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

//Create dash effect
var dash = instance_create(x, y, obj_dash_effect);
dash.sprite_index = sprite_index;
dash.image_index = image_index;
dash.depth = depth;

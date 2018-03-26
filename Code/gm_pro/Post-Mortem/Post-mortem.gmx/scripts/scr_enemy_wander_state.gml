///scr_enemy_wander_state
scr_check_for_player();

var hspd = sign(targetx - x) * spd;
var vspd = sign(targety - y) * spd;

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

/// angular_speed_correction ( )
/*
    c_speed == dx ratio dy
    
    angle == 0 ? dx = 1 dy = 0
    angle == 45 ? dx = 0.5 dy = 0.5
    angle == 90 ? dx = 0 dy = 1
    angle == 135 ? dx = -0.5 dy = 0.5
    angle == 180 ? dx = -1 dy = 0
    angle == 225 ? dx = -0.5 dy = -0.5
    angle == 270 ? dx = 0 dy = -1
    angle == 315 ? dx = 0.5 dy = -0.5
*/

c_quadrant = floor(c_angle / 90); // 0 - 3

c_ratio = c_angle mod 90; // 0 - 89

if (c_quadrant == 1 || c_quadrant == 3)
    c_ratio = 90 - c_ratio;   

dy = c_ratio / 90;
dx = (90 - c_ratio) / 90;


if (c_quadrant == 1 || c_quadrant == 2)
    dx *= -1;
if (c_quadrant == 0 || c_quadrant == 1)
    dy *= -1;
    
dx = c_speed * dx;
dy = c_speed * dy;

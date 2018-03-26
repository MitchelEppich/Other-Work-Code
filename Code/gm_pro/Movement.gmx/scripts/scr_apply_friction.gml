/// scr_apply_friction( )
if (hspeed != 0) hspeed = scr_lerp(hspeed, 0, c_friction);

c_grounded = collision_detected(x, y);
if (!c_grounded) vspeed = scr_lerp(vspeed, 1000000, c_gravity);
else if (vspeed != 0) vspeed = 0;

/// scr_control_with(input)
var key = argument0;

if (key)
{
    if (_with)
    {
        _with._with = noone;
        _with._follow = noone;
        _with = noone;
        _follow = noone;
    } else {
        _with = obj_soldier;
        oSoldier._follow = obj_player;
    }
}

if (_with)
{
    if (place_free(x - (_with.follow_distance * x_scale), y))
    {
        _with.x = x - (_with.follow_distance * x_scale);
    }
    _with.x_scale = x_scale;

    if (point_distance(0, _with.y, 0, y) > 5)
    {
        _with._with = noone;
        _with._follow = noone;
        _with = noone;
        _follow = noone;
    }
}

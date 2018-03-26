/// scr_lerp ( start, end, rate )
if (argument0 != argument1)
    if (argument0 < argument1)
        return min(argument1, argument0 + argument2)
    else
        return max(argument1, argument0 - argument2);
else return argument0;

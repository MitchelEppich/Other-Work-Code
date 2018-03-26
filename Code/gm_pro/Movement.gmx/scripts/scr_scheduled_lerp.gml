/// scr_scheduled_lerp ( start, end, rate, time_trigger )
if (argument0 != argument1 && time_trigger(argument3))
    if (argument0 < argument1)
        return min(argument1, argument0 + argument2)
    else
        return max(argument1, argument0 - argument2);
else return argument0;

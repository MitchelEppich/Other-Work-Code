/// handle_contagion ( )
if (c_isFire != 0) 
{
    c_health = scr_scheduled_lerp(c_health, 0, obj_fire.c_damage, obj_fire.c_rateOfDamage );
    c_isFire = scr_scheduled_lerp(c_isFire, 0, 1, obj_fire.c_rateOfRemoval);
    if (c_isFire > 10) transfer_contagion("FIRE");
}   
/*
if (c_isWet != 0) 
{
    c_speed = scr_scheduled_lerp(c_speed, 0, obj_water.c_damage, obj_water.c_rateOfDamage );
    c_isWet = scr_scheduled_lerp(c_isWet, 0, 1, obj_water.c_rateOfRemoval);
}   

if (c_isFrozen != 0)
{
    c_health = scr_scheduled_lerp(c_health, 0, obj_fire.c_damage, obj_fire.c_rateOfDamage );
    c_isFire = scr_scheduled_lerp(c_isFire, 0, 1, obj_fire.c_rateOfRemoval);
}   

if (c_isDehydrated != 0) 
{
    c_health = scr_scheduled_lerp(c_health, 0, obj_fire.c_damage, obj_fire.c_rateOfDamage );
    c_isFire = scr_scheduled_lerp(c_isFire, 0, 1, obj_fire.c_rateOfRemoval);
}   

if (c_isStunned != 0) 
{
    c_health = scr_scheduled_lerp(c_health, 0, obj_fire.c_damage, obj_fire.c_rateOfDamage );
    c_isFire = scr_scheduled_lerp(c_isFire, 0, 1, obj_fire.c_rateOfRemoval);
}   

if (c_isCold != 0) 
{
    c_health = scr_scheduled_lerp(c_health, 0, obj_fire.c_damage, obj_fire.c_rateOfDamage );
    c_isFire = scr_scheduled_lerp(c_isFire, 0, 1, obj_fire.c_rateOfRemoval);
}   

if (c_isHot != 0) 
{
    c_health = scr_scheduled_lerp(c_health, 0, obj_fire.c_damage, obj_fire.c_rateOfDamage );
    c_isFire = scr_scheduled_lerp(c_isFire, 0, 1, obj_fire.c_rateOfRemoval);
}   

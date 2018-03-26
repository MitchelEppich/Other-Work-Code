/// @description Insert description here
// You can write your code in this editor
var RandMove = irandom(room_speed*1)
var WanderDist = 100 //The distance in pixels your object will wander

if (RandMove = 0) 
{
    DestX = min(room_width - 20, max(20, (x + irandom_range(-WanderDist, WanderDist))));
    DestY = min(room_height - 20, max(20, (y + irandom_range(-WanderDist, WanderDist))));
}
else
{
    mp_potential_step_object(DestX, DestY, 2, oObstacle);
}
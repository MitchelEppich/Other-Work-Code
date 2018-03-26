/// @description Insert description here
// You can write your code in this editor

//Shortcuts for keypresses
//MOVELEFT = keyboard_check(vk_left);
//MOVERIGHT = keyboard_check(vk_right);
//MOVEUP = keyboard_check(vk_up);
//MOVEDOWN = keyboard_check(vk_down);
MOVELEFT = keyboard_check(ord("A"));
MOVERIGHT = keyboard_check(ord("D"));
MOVEUP = keyboard_check(ord("W"));
MOVEDOWN = keyboard_check(ord("S"));
FIRE = keyboard_check(vk_space);

//Move Player
if (MOVELEFT && x > 0) 
{ 
    x -= playerSpeed; 
}

if (MOVERIGHT && x < room_width) 
{ 
    x += playerSpeed; 
}

if (MOVEUP && y > 0) 
{ 
    y -= playerSpeed; 
}

if (MOVEDOWN && y < room_height) 
{ 
    y += playerSpeed; 
}
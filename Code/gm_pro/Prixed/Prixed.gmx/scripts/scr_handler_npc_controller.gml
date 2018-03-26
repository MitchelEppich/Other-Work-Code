populated = 0;

tag = "";

action = "";

dir = 1;

alive = true;

hit_points = 0;
max_hit_points = -10;
base_damage = 0;

item_selected = 0;
current_items = ds_list_create();

gold = 0;

hspd = 0;
jump_height = 0;

death_tick = 0;

targets = 0;

master = "";

team = 0;
targeted = noone;

mass = 0;

creator = -1;

//DO NOT CALL THIS TAMPERS! SOMETHING IS WRONG IN PROGRAM WHEN NAMED TAMPER
//tampers = "";
tampers = ds_list_create();

coin = 0;

interacting = false;

swimming = false;
attack = false;
stealth = false;
chat = false;

inCombat = false;

fric = global.fric;

experience = 0;

level = 1;

inventory = ds_grid_create(2, 32);
hotbar_start = 0;

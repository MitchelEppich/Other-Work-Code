/// @description Insert description here
// You can write your code in this editor

var enemy = collision_rectangle(x - (sprite_width / 2), y, x + (sprite_width/2), y + sprite_height, obj_villager, false, true)
if (enemy != noone) {
	state = scr_fight_enemy
	script_execute(state, enemy)
} else if instance_find(obj_tree, 0) != noone{
	state = scr_collect_wood
	script_execute(state)
} else if instance_find(obj_rock, 0) != noone{
	state = scr_collect_wood
	script_execute(state)
} else if wood_storage > 0 {
	state = scr_deliver_wood
	script_execute(state)
} else if rock_storage > 0 {
	state = scr_deliver_wood
	script_execute(state)
} else if wood_storage == 0 || rock_storage == 0 {
	state = scr_pillage_hut
	script_execute(state)
}
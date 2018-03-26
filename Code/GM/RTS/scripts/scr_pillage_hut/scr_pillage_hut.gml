hut = instance_find(obj_hut, irandom(instance_number(obj_hut) - 1))

if hut == home || hut.wood_storage == 0 {
	exit
}

move_towards_point(hut.x, hut.y, spd)

if place_meeting(x, y, hut) {
	wood_storage += hut.wood_storage
	hut.wood_storage = 0
	speed = 0
}
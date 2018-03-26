move_towards_point(home.x, home.y, spd)

if place_meeting(x, y, home) {
	home.wood_storage += wood_storage
	home.rock_storage += rock_storage
	wood_storage = 0
	rock_storage = 0
	speed = 0
}
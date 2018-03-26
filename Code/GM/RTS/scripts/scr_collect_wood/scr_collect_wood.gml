// Look for tree
var tree = instance_nearest(x, y, obj_tree)
var rock = instance_nearest(x, y, obj_rock)

// Go to tree
if (instance_exists(tree)) {
	move_towards_point(tree.x, tree.y, spd)
}

// Collect tree
if (place_meeting(x, y, tree)) {
	instance_destroy(tree.id)
	tree = noone;
	wood_storage += 10
	speed = 0
}

// Collect rock
if (place_meeting(x, y, rock)) {
	instance_destroy(rock.id)
	tree = noone;
	rock_storage += 10
	speed = 0
}
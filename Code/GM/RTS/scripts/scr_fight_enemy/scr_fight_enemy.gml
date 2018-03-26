// Roll a random value
var enemy = argument0

var attack_modifier = irandom(10)

if (attack_modifier > 4) {
	wood_storage += enemy.wood_storage
	instance_destroy(enemy.id)
	speed = 0
}
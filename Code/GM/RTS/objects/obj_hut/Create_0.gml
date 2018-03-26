/// @description Insert description here
// You can write your code in this editor
villagers = []

wood_storage = 0
rock_storage = 0

var villager = instance_create_layer(x, y, "Instances", obj_villager)
villager.home = self
villagers[0] = villager
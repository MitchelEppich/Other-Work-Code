/// @description Insert description here
//// Harvest
if is_harvestable && keyboard_check_pressed(ord("S")) 
{
	var list = global.playerRef.inventory;
	
	// Collect the item
	index = ds_list_contains(list, "food|" + name);
	if (index != -1)
	{
		val = string_split("|", list[| index], true);
		val = real(val[2]);
		ds_list_replace(list, index, "food|" + name + "|" + string(quantity + val));
	}
	else 
	{
		ds_list_add(list, "food|" + name + "|" + string(quantity));
	}

	// Possibly add seeds to the players inventory
	if random(1) >= 1 - seed_chance 
	{
		index = ds_list_contains(list, "seed|" + name);
		if (index != -1)
		{
			val = string_split("|", list[| index], true);
			val = real(val[2]);
			ds_list_replace(list, index, "seed|" + name + "|" + string(seed_quantity + val));
		}
		else 
		{
			ds_list_add(list, "seed|" + name + "|" + string(seed_quantity));
		}
	}
	
	// Destroy object
	instance_destroy();
}
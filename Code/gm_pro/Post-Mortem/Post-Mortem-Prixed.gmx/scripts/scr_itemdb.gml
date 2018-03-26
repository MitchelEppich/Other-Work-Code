// Inventory
global.items = ds_map_create();
var sprite = spr_inventory_tabs;
var std_offset = 15;
var scale = 3.25;


ds_map_add(global.items, "sword", scr_element_create(-1, sprite, std_offset * 4, 0, scale, c_white, 1, "item", "sword", "Looks great on any wall.", scr_stat_create(r(), r(), r(), r()), 0, "comment::This is just the edge you needed."));
ds_map_add(global.items, "fruit", scr_element_create(-1, sprite, std_offset * 4, 0, scale, c_white, 1, "consume", "fruit", "Prepare for the scrumptious juices of a fruit.", scr_stat_create(r(), r(), r(), r()), 2, "comment::You hear a faint scream as you firmly grasp the fruit."));
ds_map_add(global.items, "shield", scr_element_create(-1, sprite, std_offset * 4, 0, scale, c_white, 1, "hand", "shield", "Hide behind this, it will prove to be a handsome companion.", scr_stat_create(r(), r(), r(), r()), 4, "comment::You find this heavy, you are displeased."));
ds_map_add(global.items, "boots", scr_element_create(-1, sprite, std_offset * 4, 0, scale, c_white, 1, "feet", "boots", "Great way to prevent death to the foot babies. Preserve the foot babies.", scr_stat_create(r(), r(), r(), r()), 6, "comment::These look warm and well fitted."));
ds_map_add(global.items, "bow", scr_element_create(-1, sprite, std_offset * 4, 0, scale, c_white, 1, "item", "bow", "A couple strings away from a harp. Impress all your...-Ha.", scr_stat_create(r(), r(), r(), r()), 8, "comment::Nice peice of wood."));
ds_map_add(global.items, "arrow", scr_element_create(-1, sprite, std_offset * 4, 0, scale, c_white, 1, "back", "arrow", "Launch one of these and we gaurentee the mood will flip on its head.", scr_stat_create(r(), r(), r(), r()), 10, "comment::You giggle. Those feathers look #like they could be very tickily."));
ds_map_add(global.items, "pants", scr_element_create(-1, sprite, std_offset * 4, 0, scale, c_white, 1, "leg", "pants", "NO! No one wants to see that! Sick bastard, thinking you can live without pants.", scr_stat_create(r(), r(), r(), r()), 12, "comment::Commonly forgotten by many nasty people."));
ds_map_add(global.items, "shirt", scr_element_create(-1, sprite, std_offset * 4, 0, scale, c_white, 1, "torso", "shirt", "A great way to keep Mr. Sun from toasting the nips.", scr_stat_create(r(), r(), r(), r()), 14, "comment::You carress your flesh with the soft cotton."));
ds_map_add(global.items, "fish", scr_element_create(-1, sprite, std_offset * 4, 0, scale, c_white, 1, "consume", "fish", "A rare species. Stop questioning and just eat it.", scr_stat_create(r(), r(), r(), r()), 16, "comment::Taste like fish, feels like fish, looks like a fish corpse."));
ds_map_add(global.items, "potion", scr_element_create(-1, sprite, std_offset * 4, 0, scale, c_white, 1, "consume", "potion", "In this case, do not listen to your mother.#Because if this was the bridge, everyone#would be doing it.", scr_stat_create(r(), r(), r(), r()), 18, "comment::You see hair, scabs and feces."));
ds_map_add(global.items, "glove", scr_element_create(-1, sprite, std_offset * 4, 0, scale, c_white, 1, "hand", "glove", "Keep the hand growths warm and safe from scary Mr. Wind.", scr_stat_create(r(), r(), r(), r()), 20, "comment::The seam is coming undone."));
ds_map_add(global.items, "heart", scr_element_create(-1, sprite, std_offset * 4, 0, scale, c_white, 1, "consume", "heart", "An adorable little heart.#One of the last of their species.", scr_stat_create(r(), r(), r(), r()), 22, "comment::The little heart cries but you will consume it sooner or later."));
ds_map_add(global.items, "bomb", scr_element_create(-1, sprite, std_offset * 4, 0, scale, c_white, 1, "item", "bomb", "A bomb, very dangerous. Not fun for the family.", scr_stat_create(r(), r(), r(), r()), 24, "comment::Just one light and you will be out of sight."));
ds_map_add(global.items, "helmet", scr_element_create(-1, sprite, std_offset * 4, 0, scale, c_white, 1, "head", "helmet", "A strong helmet to protect a thin skull.", scr_stat_create(r(), r(), r(), r()), 26, "comment::You can imagine how cool you will look in this."));


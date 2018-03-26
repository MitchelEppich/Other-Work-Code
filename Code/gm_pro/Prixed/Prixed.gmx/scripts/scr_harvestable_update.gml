///scr_havestable_update(id)
var this = argument0;
depth = -y;

var inst = instance_place(x, y, obj_npc);
if(inst == noone || !instance_exists(inst)) exit; 

if(inst != noone && string(ds_grid_get(inst.inventory, 0, inst.item_selected)) == reqTool && inst.attack && harvestable) {
    this.hit_points -= 1;
    
    if(this.hit_points <= 0) {
        this.harvestable = false;
        image_index += 1;
        scr_inventory_add(inst, resource, amount);
        
    }
} else if(!this.harvestable) {
    this.state = 0;
    this.harvestable = true;
}

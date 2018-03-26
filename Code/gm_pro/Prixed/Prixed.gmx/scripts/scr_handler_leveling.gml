var this = argument0;
var amount = argument1;

if(global.tick mod 100 == 0) {
    scr_inventory_add(this, "experience", 10 * global.wave);
}

var expr = ds_grid_get(this.inventory, 1, scr_grid_find_value(this.inventory, "experience"));

if(expr >= global.level_up * this.level) {
    scr_inventory_add(this, "experience", -(global.level_up * this.level));
    this.level++;
    scr_part_level_up();
}
with this {
if(level == 1 && !scr_grid_exists(inventory, "punch")) scr_inventory_add(this, "punch", -1);
if(level == 2 && !scr_grid_exists(inventory, "stab")) scr_inventory_add(this, "stab", 500);
if(level == 2 && !scr_grid_exists(inventory, "hack")) scr_inventory_add(this, "hack", 20);
if(level == 3 && !scr_grid_exists(inventory, "arrow")) scr_inventory_add(this, "arrow", 100);
if(level == 4 && !scr_grid_exists(inventory, "fireball")) scr_inventory_add(this, "fireball", 50);
if(level == 5 && !scr_grid_exists(inventory, "heal")) scr_inventory_add(this, "heal", 10);
if(level == 6 && !scr_grid_exists(inventory, "regenerate")) scr_inventory_add(this, "regenerate", 2);
if(level == 7 && !scr_grid_exists(inventory, "harden")) scr_inventory_add(this, "harden", 5);
if(level == 8 && !scr_grid_exists(inventory, "javelin")) scr_inventory_add(this, "javelin", 10);
if(level == 9 && !scr_grid_exists(inventory, "slash")) scr_inventory_add(this, "slash", 200);
if(level == 10 && !scr_grid_exists(inventory, "teleport")) scr_inventory_add(this, "teleport", 3);
}

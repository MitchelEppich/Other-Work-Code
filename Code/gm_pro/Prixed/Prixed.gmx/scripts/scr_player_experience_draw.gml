///scr_player_experience_draw(id)
var this = argument0;
var sizeXP = 167;
for(var i = 0; i < sizeXP; i++) {
    
    var expr = ds_grid_get(this.inventory, 1, scr_grid_find_value(this.inventory, "experience"));
    var c;    

    if(((global.level_up * level) / sizeXP) * i <= expr) c = 1;
    else if(((global.level_up * level) / sizeXP) * i > expr) c = 4;
    
    if(i == 0 && expr != 0) c = 0;
    else if(i == 0 && expr <= 0) c = 3;
    
    if(i == (sizeXP - 1) && expr == (global.level_up * level)) c = 2;
    else if(i == (sizeXP - 1) && expr != (global.level_up * level)) c = 5;
    
    draw_sprite_ext(spr_health_bar, c, 10 + (sprite_get_width(spr_health_bar) * scale * i), 675, scale, scale, 0, -1, 1);
}

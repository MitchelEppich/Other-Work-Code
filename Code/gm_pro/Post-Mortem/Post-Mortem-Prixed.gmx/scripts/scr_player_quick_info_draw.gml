///scr_player_quick_info_draw(id)
var this = argument0;
// Info Draw

var scale = 3;
var size = 50;

if(global.current_hit_points == 0) global.current_hit_points = this.hit_points;
for(var i = 0; i < size; i++) {
    
    var c;    

    if((global.current_hit_points / size) * i <= this.hit_points) c = 1;
    else if((global.current_hit_points / size) * i > this.hit_points) c = 4;
    
    if(i == 0 && this.hit_points != 0) c = 0;
    else if(i == 0 && this.hit_points <= 0) c = 3;
    
    if(i == (size - 1) && this.hit_points == global.current_hit_points) c = 2;
    else if(i == (size - 1) && this.hit_points != global.current_hit_points) c = 5;
    
    draw_sprite_ext(spr_health_bar, c, 64 + (sprite_get_width(spr_health_bar) * scale * i), 64, scale, scale, 0, -1, 1);
}

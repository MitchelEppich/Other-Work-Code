this = argument0;

if(this.interacting) {
    draw_set_colour(c_green);
    draw_circle(this.x + (abs(sprite_width) / 2), this.y - sprite_height, 3, 0);
    
}

draw_self();

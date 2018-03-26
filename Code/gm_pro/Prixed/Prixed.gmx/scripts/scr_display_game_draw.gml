if(global.paused) {
    if(global.sprite == -1)
        global.sprite = sprite_create_from_surface(application_surface, 0, 0, room_width, room_height, 0, 0, 0, 0);
    
    depth = 10;
    draw_sprite(global.sprite, -1, 0, 0);   
} else global.sprite = -1;

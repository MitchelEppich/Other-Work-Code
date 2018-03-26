///scr_display_speech(id)
var this = argument0;
var txt = keyboard_string;

if(this.chat) {
    draw_set_font(font_main);
    draw_set_halign(fa_center);
    var colour = c_white;
    
    draw_text_transformed_colour(this.x, this.y - this.sprite_height * 1.05, txt, 0.5, 0.5, 0, colour, colour, colour, colour, 0.6);
    
    if(keyboard_check_pressed(global.enter)) {
        var caption = instance_create(this.x, this.y - this.sprite_height * 1.05, obj_caption);
        caption.text = txt;
        this.chat = false;
    }
    
} else if(populated) 
    keyboard_string = "";


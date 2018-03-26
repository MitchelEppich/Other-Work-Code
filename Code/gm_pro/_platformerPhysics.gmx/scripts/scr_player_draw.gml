/// scr_player_draw()
// Draw head
draw_sprite_ext(spr_human_head, 0, x, y - 19 + (sin(current_second)), x_scale * 3, y_scale * 3, 0, c_white, 1);

// Draw torso
draw_sprite_ext(spr_human_torso, 0, x, y - 8, x_scale * 3, y_scale * 3, 0, c_white, 1);

// Draw left arm
draw_sprite_ext(spr_human_arm, 0, x - 3, y - 13 - (sin(current_second)), -x_scale * 3, y_scale * 3, 0, c_white, 1);

// Draw left arm
draw_sprite_ext(spr_human_arm, 0, x + 6, y - 13 - (sin(current_second)), x_scale * 3, y_scale * 3, 0, c_white, 1);

// Draw left foot
draw_sprite_ext(spr_human_foot, 0, x - 0, y - 2, -x_scale * 3, y_scale * 3, 0, c_white, 1);

// Draw right foot
draw_sprite_ext(spr_human_foot, 0, x + 3, y - 2, x_scale * 3, y_scale * 3, 0, c_white, 1);

/*
// Draw head
draw_rectangle((x - 4), (y - 22), (x + 4), (y - 14), false);

// Draw torso
draw_rectangle((x - 4), (y - 13), (x + 4), (y - 3), false);

// Draw left arm
draw_rectangle((x - 7), (y - 13), (x - 5), (y - 5), false);

// Draw right arm
draw_rectangle((x + 7), (y - 13), (x + 5), (y - 5), false);

// Draw left leg
draw_rectangle((x - 4), (y - 2), (x - 2), (y), false);

// Draw right leg
draw_rectangle((x + 4), (y - 2), (x + 2), (y), false);

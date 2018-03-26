/// scr_character_create()
var sprite = spr_human_preview;
var xoffset = 200;
var yoffset = 0;
var scale = 24;
var color = c_white;
var alpha = 1;
var name = scr_generate_name();
var index = irandom(5);
var action = scr_generate_action();

return scr_element_create(-1, sprite, xoffset, yoffset, scale, color, alpha, -1, name, -1, -1, index, action);

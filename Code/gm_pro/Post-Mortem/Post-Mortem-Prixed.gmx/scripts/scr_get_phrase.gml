/// scr_get_phrase(who)

var k = argument0;

var c = choose(k[? "info"], k[? "speech"]);

return c[| irandom(ds_list_size(c) - 1)];

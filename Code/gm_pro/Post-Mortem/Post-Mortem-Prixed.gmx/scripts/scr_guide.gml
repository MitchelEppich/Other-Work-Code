/// scr_guide()

var p = ds_queue_create();
var e = ds_queue_create();
var ed = ds_map_create();

ed[? "worried"] = spr_guide_worried;
ed[? "happy"] = spr_guide_happy;
ed[? "cheeky"] = spr_guide_cheeky;
ed[? "suprised"] = spr_guide_suprised;
ed[? "disappointed"] = spr_guide_disappointed;
ed[? "scared"] = spr_guide_scared;
ed[? "shocked"] = spr_guide_shocked;
ed[? "calm"] = spr_guide_calm;
ed[? "silent"] = spr_guide_silent;

var map = ds_map_create();
map[? "phrase"] = p;
map[? "expression"] = e;
map[? "e_data"] = ed;

return map;

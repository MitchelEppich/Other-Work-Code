/// scr_keeper_bloom()

var ih = ds_map_create(); // inventory holder
var i = ds_list_create(); // inventory
var n = ds_list_create(); // info
var d = ds_map_create(); // detail
var s = ds_list_create(); // speech
var p = ds_map_create(); // preview
var k = ds_map_create(); // keeper

d[? "name"] = "Mrs. Bloom";
d[? "age"] = "34";
d[? "rates"] = "0.67";
d[? "coins"] = 13854;
d[? "scene"] = spr_store_keeper_bloom;

p[? "title"] = "Welcome";
p[? "phrase"] = "This is my shop, enjoy!";

ih[? "inventory"] = i;
ih[? "selection"] = 0;

i[| 0] = scr_get_object(global.items, "fruit");
i[| 1] = scr_get_object(global.items, "fish");
i[| 2] = scr_get_object(global.items, "bomb");
i[| 3] = scr_get_object(global.items, "fruit");
i[| 4] = scr_get_object(global.items, "arrow");

n[| 0] = "You must meet my parents... was that to forward?";
n[| 1] = "My husband is quite the charmer, one for every memeory.";
n[| 2] = "I suffer from a disease that eats away at me, can't do much with rusty nuts and bolts.";
n[| 3] = "I used to be an entertainer at a local bar, the 'Oil Spill'.";
n[| 4] = "You would adore my little one, busted a nut on the sidewalk. Tragic really.";

s[| 0] = "I once had a sale. I can be pretty hip you know.";
s[| 1] = "My items are not to fancy but they are products of love.";
s[| 2] = "¡Fuera! Ich liebe einen guten Ölwechsel. Oh my! Tweaking somethings.";
s[| 3] = "I worry if I leave the rust would only spread, cruel humidity.";
s[| 4] = "Where is all my money? Oh I see I left it in your pocket. Trade?";

k[? "info"] = n;
k[? "inv_holder"] = ih;
k[? "speech"] = s;
k[? "detail"] = d;
k[? "preview"] = p;

return k;

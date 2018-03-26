/// scr_price_object(object)

var stat = argument0[? "stat"];
var d = stat[? "defence"];
var s = stat[? "speed"];
var h = stat[? "health"];
var a = stat[? "attack"];
// 2, 13, 1, 0
var count = 0;
if (h != 0)count++;
if (d != 0)count++;
if (a != 0)count++;
if (s != 0)count++;

// 0.0533_
var rarity = 0;
rarity = h + d + a + s;
rarity /= count * 100;

// 0.75, 3.9, 0.5, 0
// Weight stats
h *= 0.15;
d *= 0.3;
a *= 0.5;
s *= 0.05;
//0.87821 * (0.0533_ * 100)
var price = (h + (((s + a)%d)/ d)) * (rarity * 100);

return price;

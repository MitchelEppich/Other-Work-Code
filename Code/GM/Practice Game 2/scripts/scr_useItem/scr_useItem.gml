/// @description Use the specific item
var list = argument0;
var index = argument1;

// Get item from list
var str = list[| index];
str = string_split("|", str, true);

// Break down the string collected
var name, quantity, def;
var size = array_length_1d(str);
if size == 2
{
	name = str[0];
	quantity = str[1];
}
else if size == 3
{
	name = str[0];
	def = str[1];
	quantity = str[2];
}

var isUsed = false;
switch name
{
	case "seed":
	isUsed = scr_useSeed(def);
	break;
	case "food":
	isUsed = scr_useFood(def);
	break;
}

if isUsed quantity = string(real(quantity) - 1);

if quantity == "0" 
	ds_list_delete(list, index);
else
	ds_list_replace(list, index, name + "|" + def + "|" + quantity);

return list;
var list = argument0;
var value = argument1;

var size = ds_list_size(list);
for (i = 0; i < size; i++) 
{
	var subString = list[| i];
	subString = string_split("|", subString, true);
	subString = subString[0] + "|" + subString[1];
	
	if value == subString return i;
}

return -1;
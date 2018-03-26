/// scr_dev_cmd_give (type, amount)
var type = noone;

switch (argument0) {
// Health
case "health":
type.hp += argument1;
break;
// Default
default:
unknown = true;
break;
}

if(unknown) return 0;

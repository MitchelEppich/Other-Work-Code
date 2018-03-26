var type = argument0;
type = string_lower(type);

switch(type) {
    case "hospital":
    scr_shop_hospital();
    break;
    case "armoury":
    scr_shop_armoury();
    break;
    case "magic":
    scr_shop_magic();
    break;
}

return true;

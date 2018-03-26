/// transfer_contagion ( type )
c_instance = instance_place(x, y, all);

if (c_instance == noone)
    exit;

with c_instance
{
    switch (argument0)
    {
        case "FIRE" : 
            if (c_isFrozen)
            {
                //c_isWet += min(c_isWet + obj_water.c_rateOfContraction, 20);
                c_isFrozen = 0;
            } else if (c_isWet)
            {
                c_isWet = 0;
            } else c_isFire = min(c_isFire + obj_fire.c_rateOfContraction, 20);
            break;
        case "WATER" :
            if (c_isFire)
            {
                c_isFire = 0;
            } else if (c_isCold)
            {
                //c_isFrozen += min(c_isFrozen + obj_water.c_rateOfContraction, 20);
            } //else c_isWet += min(c_isWet + obj_water.c_rateOfContraction, 20);
            break;
    }
}

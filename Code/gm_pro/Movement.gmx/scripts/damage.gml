/// damage ( amount )
c_instance = instance_place(x, y, all);

if (c_instance == noone || c_parent != noone)
    exit;

if (c_instance.c_type == "NPC" && c_instance.c_id != c_creator)
{
    with c_instance
    {
        c_health -= argument0;
    }
    
    instance_destroy();
}

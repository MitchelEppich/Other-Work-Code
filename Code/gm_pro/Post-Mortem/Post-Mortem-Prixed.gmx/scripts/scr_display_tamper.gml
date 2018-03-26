tamper = argument0;

if(string_pos("poison", tamper) != 0) scr_part_sick_bubbles();
if(string_pos("fire", tamper) != 0) scr_part_fire();
if(string_pos("punch", tamper) != 0) scr_part_blood_splatter();
if(string_pos("arrow", tamper) != 0) scr_part_blood_splatter();
if(string_pos("hack", tamper) != 0) scr_part_blood_splatter();
if(string_pos("slash", tamper) != 0) scr_part_blood_splatter();
if(string_pos("stab", tamper) != 0) scr_part_blood_splatter();
if(string_pos("javelin", tamper) != 0) scr_part_blood_splatter();
if(string_pos("heal", tamper) != 0) scr_part_heal();
if(string_pos("regenerate", tamper) != 0) scr_part_regenerate();
if(string_pos("harden", tamper) != 0) {
    scr_part_harden();
    show_debug_message("yep");
}







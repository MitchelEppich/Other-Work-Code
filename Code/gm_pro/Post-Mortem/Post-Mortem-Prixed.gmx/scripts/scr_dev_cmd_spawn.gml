/// scr_dev_cmd_spawn (type, amount, enabled)
var type = noone;
var sprite = noone;
var costume = noone;

switch (argument0) {
// Basic Human
case "human":
type = obj_human;
sprite = spr_human;
break;
// Mailman
case "mailman":
type = obj_human;
sprite = spr_human;
costume = spr_human_costume_mailman;
break;
// Theif
case "theif":
type = obj_human;
sprite = spr_human;
costume = spr_human_costume_theif;
break;
// Package
case "package":
type = obj_package;
sprite = spr_package;
break;
// Cargo
case "cargo":
type = obj_cargo;
break;
// Default
default:
unknown = true;
break;
}

if(unknown) return 0;

repeat(argument1) {
    var inst = instance_create (irandom(room_width), 50, type);
    inst.enabled = real(argument2);
    inst.costume = costume;
    inst.sprite = sprite;
    inst.team = choose("foe", "ally");
}

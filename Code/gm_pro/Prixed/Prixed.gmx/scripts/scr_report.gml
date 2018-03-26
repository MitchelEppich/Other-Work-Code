var this = argument0;
var whois = this.tag;

var team = this.team;

var whatis = argument1;

if(whatis == "") exit;

var key = string(team) + "_" + string(whatis);
var value = ds_map_find_value(global.game_total, key) + 1;

//show_debug_message(string(key) + " " + string(value));

if(whatis == "kill") ds_map_replace(global.game_total, key, value);
if(whatis == "spawn") ds_map_replace(global.game_total, key, value);
if(whatis == "death") ds_map_replace(global.game_total, key, value);
if(whatis == "damage") ds_map_replace(global.game_total, key, value);
if(whatis == "energy") ds_map_replace(global.game_total, key, value);
if(whatis == "distance") ds_map_replace(global.game_total, key, value);
if(whatis == "coin") ds_map_replace(global.game_total, key, value);

if(whatis == "quest") ds_map_replace(global.game_total, key, value);
if(whatis == "achievement") ds_map_replace(global.game_total, key, value);

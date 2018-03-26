///scr_generate_quest()
var quest = "->get!" + string(irandom(50)+1) + ":";

quest += choose("log", "rock", "dirt", "apple", "strudel", "beef") + "?";
quest += choose("reville", "farm", "hospital", "moms", "pump");
quest += "<goto::rm_game>";

return quest;

///scr_mail_job_controller()
var this = argument0;

if(type == "foe") {
    spec = choose("spam", "thief", "hazard", "", "", "", "", "", "");
    var spec_marker = 0;
    
    switch(spec) {
    case "spam":
    scr_spec_spam(id);
    spec_marker = spr_marker_spam;
    break;
    case "thief":
    scr_spec_thief(id);
    spec_marker = spr_marker_theft;
    break;
    case "hazard":
    scr_spec_hazard(id);
    spec_marker = spr_marker_hazard;
    break;
    }
    
    if(spec != "") {
        var marker = instance_create(x, y, obj_marker);
        marker.target = id;
        marker.sprite_index = spec_marker;
        marker.image_xscale = 0.75;
        marker.image_yscale = 0.75;
        marker.image_speed = 0.2;
    }
}

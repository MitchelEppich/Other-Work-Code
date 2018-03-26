/// scr_acquire_dest()

switch(global.destination) {
    case "reville":
        return scr_dest_reville;
    case "moms":
        return scr_dest_moms;
    case "library":
        return scr_dest_library;
    case "pump":
        return scr_dest_pump;
    case "farm":
        return scr_dest_farm;
    case "hospital":
        return scr_dest_hospital;
    case "stadium":
        return scr_dest_stadium;
    case "militia":
        return scr_dest_militia;
    case "office":
        return scr_dest_office;
    case "command":
        return scr_dest_command;
    case "castle":
        return scr_dest_castle;
    case "factory":
        return scr_dest_factory;
    case "market":
        return scr_dest_market;
    case "park":
        return scr_dest_park;
    case "barust":
        return scr_dest_barust;
    case "spectra":
        return scr_dest_spectra;
    default:
        show_debug_message("Error : No Match <scr_acquire_dest> input=" + string(global.destination));
        room_goto(rm_newMenu);
}

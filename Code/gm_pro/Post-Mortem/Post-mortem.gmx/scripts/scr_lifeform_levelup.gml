///scr_lifeform_levelup(id, levelsToAdvance)
var levelsToAdvance = argument1;
var creator = argument0;

repeat(levelsToAdvance) {
    with(creator) {
        level++;
        experience -= experienceTo;
        
        // Advance skills
        attack *= 1.01;
        strength *= 1.02;
        
        experienceTo = ceil(experienceTo * 2.8);
    }
}

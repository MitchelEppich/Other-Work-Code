/// scr_enum()

enum style 
{
    smash,
    slash,
    block,
    stab
}

enum common
{
    stand = 0,
    walk = 1,
    run = 2,
    scale = 3,
    jump = 4,
    roll = 5,
    attack = 6,
    stun = 7,
    death = 8  
}

enum stealth
{
    stand = 100,
    walk = 101,
    run = 102
}

enum communal
{
    stand_with = 200,
    stand_follow = 201,
    walk_with = 202,
    walk_follow = 203,
    run_with = 204,
    run_follow = 205
}

enum state 
{
    common,
    stealth,
    communal
}

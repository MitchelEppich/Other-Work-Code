///scr_game_welcome()

// play ingame music
sound_loop(snd_temp_bg);
sound_volume(snd_temp_bg, 0.3);

// play welcome note from developers
sound_play(snd_welcome);
show_message("Welcome to the Prixed prototype! #We am excited to show the community what we have
been working on for some time and hope you enjoy playing around with it.#Bareware Games.");

// present instructions
show_message("--Controls--# Move Left : <left arrow>      Move Right : <right arrow>
#Attack : <'X'>     Jump : <space>
#Interact : Hold <'Z'>#Buildings rapidly regain health.#Switch Weapon : <up and down arrow>     Move Hotbar : <shift> + <up and down arrow>
#Stay in stores till clock finishes to enter the store to buy items!#Recieve weapons as you level up over time#Use attack <hack> to chop down trees for arrows");

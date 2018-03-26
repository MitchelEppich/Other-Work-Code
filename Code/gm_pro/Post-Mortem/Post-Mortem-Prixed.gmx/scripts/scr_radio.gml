/// scr_radio_create(id, dir)

var playlist = argument1;

var bmg = snd_ingame;

var current_snd = snd_ingame;
var next_snd = -1;

if (!audio_is_playing(bgm)) bgm = audio_play_sound(current_snd, 10, true);

audio_sound_gain(current_snd, 0.5, 0);

if (global.mute) audio_pause_sound(bgm);
if (audio_is_paused(bgm) && !global.mute) audio_resume_sound(bgm);

global.music_playing = false;

function audiomanager_play_slot_scored(){
    i = irandom_range(0,2);
	switch(i){
		case 0:
            // if(audio_exists(snd_slot_scored_1) == false){
			    audio_play_sound(snd_slot_scored_1, 0, false, 1, 0, random_range(0.8, 1.2));
            // }
			break;
		case 1:
            // if(audio_exists(snd_slot_scored_2) == false){
			    audio_play_sound(snd_slot_scored_2, 0, false, 1, 0, random_range(0.8, 1.2));
            // }
			break;
		case 2:
            // if(audio_exists(snd_slot_scored_3) == false){
			    audio_play_sound(snd_slot_scored_3, 0, false, 1, 0, random_range(0.8, 1.2));
            // }
			break;
	} 
}

function audiomanager_play_music(){
	if(global.music_playing == false){
		audio_play_sound(snd_music, 0, true, 1, 0, 1);
		global.music_playing = true;
	}
}

function audiomanager_play_turn_gained(){
	audio_play_sound(snd_bell, 0, false, 1, 0, random_range(0.95, 1.05));
}

function audiomanager_play_item_swap(){
    i = irandom_range(0,2);
	switch(i){
		case 0:
            // if(audio_exists(snd_slot_scored_1) == false){
			    audio_play_sound(snd_item_swap_1, 0, false, 1, 0, random_range(0.8, 1.2));
            // }
			break;
		case 1:
            // if(audio_exists(snd_slot_scored_2) == false){
			    audio_play_sound(snd_item_swap_2, 0, false, 1, 0, random_range(0.8, 1.2));
            // }
			break;
		case 2:
            // if(audio_exists(snd_slot_scored_3) == false){
			    audio_play_sound(snd_item_swap_3, 0, false, 1, 0, random_range(0.8, 1.2));
            // }
			break;
	} 
}

function audiomanager_play_logo_chime(){
	audio_play_sound(snd_logo_chime, 0, false, 1, 0, 1);
}

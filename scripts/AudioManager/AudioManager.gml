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
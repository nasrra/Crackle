/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

on_press = function(){
	// if(string_length(global.player_name) > 0){
		gamemanager_gameplay_state();
		room_goto(room_game);
	// }
};


/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();


if (string_length(keyboard_string) < 10) {
    text = string_upper(keyboard_string);
}
else {
	
	text = string_copy(string_upper(keyboard_string), 1, 10);
    keyboard_string = text;
}

var is_inappropriate = namefilter_is_name_inappropriate(text);
if(is_inappropriate == true){
	end_colour = c_red;
	global.player_name = "";
} 
else{
	end_colour = c_white;
	global.player_name = text;
}
text = text + cursor;

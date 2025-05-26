/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (string_length(keyboard_string) < 10) {
    text = string_upper(keyboard_string);
	text = text + cursor;
}
else {
	
	text = string_copy(string_upper(keyboard_string), 1, 10);
    keyboard_string = text;
	text = text + cursor;
}
global.player_name = text;
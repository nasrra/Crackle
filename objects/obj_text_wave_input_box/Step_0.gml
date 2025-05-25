/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (string_length(keyboard_string) < 10) {
    text = string_upper(keyboard_string);
} else {
    keyboard_string = text;
}

global.player_name = text;
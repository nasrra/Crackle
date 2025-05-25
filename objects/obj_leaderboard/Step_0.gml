/// @description Insert description here
// You can write your code in this editor
set_text();
if(keyboard_check_pressed(vk_up)){
	add_highscore("dave", 200);
}

if(keyboard_check_pressed(vk_left)){
	add_highscore("christy", 20000);
}

if(keyboard_check_pressed(vk_right)){
	remove_highscore(2);
}
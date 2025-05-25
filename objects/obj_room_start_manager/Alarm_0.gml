/// @description Insert description here
// You can write your code in this editor
if(layer_get_visible("Logo") == false){
	audiomanager_play_logo_chime();
	layer_set_visible("Logo", true);
	alarm_set(0,240);
}
else{
	layer_set_visible("Logo", false);
	alarm_set(3,30);
}

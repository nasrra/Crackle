/// @description Insert description here
// You can write your code in this editor
if(obj_mouse_cursor.item != noone){
	previous_hovered = hovered;
	hovered = position_meeting(mouse_x, mouse_y, id);
}

if(previous_hovered == true && hovered == false){
	obj_mouse_cursor.hovered_slot = noone;
}

if(hovered == true && previous_hovered == false){
	obj_mouse_cursor.hovered_slot = id;
}

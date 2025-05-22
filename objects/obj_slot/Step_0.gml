/// @description Insert description here
// You can write your code in this editor
if(obj_mouse_cursor.item != noone){
	previous_hovered = hovered;
	hovered = position_meeting(mouse_x, mouse_y, id);
}

if(previous_hovered == true && hovered == false){
	obj_mouse_cursor.hovered_slot = noone;
	idle_state();
}

if(hovered == true && previous_hovered == false){
	obj_mouse_cursor.hovered_slot = id;
	hover_state();
}

handle_scale();

scored_this_frame = false;
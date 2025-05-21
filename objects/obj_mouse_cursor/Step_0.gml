/// @description Insert description here
// You can write your code in this editor
x = mouse_x;
y = mouse_y;

show_debug_message(string(hovered_slot != noone) +" "+ string(item != noone) + " "+ string(mouse_check_button_released(mb_left) == true));


if(mouse_check_button_released(mb_left) == true){
	if(hovered_slot != noone && item != noone && mouse_check_button_released(mb_left) == true){
		obj_item_handler.swap_slots(item.slot, hovered_slot);
	}
	obj_mouse_cursor.item = noone;
}
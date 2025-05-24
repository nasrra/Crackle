/// @description Insert description here
// You can write your code in this editor
x = mouse_x;
y = mouse_y;

// show_debug_message(string(hovered_slot != noone) +" "+ string(item != noone) + " "+ string(mouse_check_button_released(mb_left) == true));
window_set_cursor(cr_none);


if(mouse_check_button_released(mb_left) == true){
	if(hovered_slot != noone && item != noone && mouse_check_button_released(mb_left) == true){
		if(hovered_slot != item.slot){
			obj_moves.add_value(-1);
			obj_item_handler.increase_difficulty();
		}
		obj_item_handler.swap_slots(item.slot, hovered_slot);
	}
	obj_mouse_cursor.item = noone;
}

sprite_index = spr_mouse_idle;
var hovered_item = instance_place(mouse_x, mouse_y, obj_item);
if(hovered_item != noone && hovered_item.is_grabbable && obj_item_handler.items_are_grabbable == true){
	sprite_index = spr_mouse_hovering;
}
var button = instance_place(mouse_x, mouse_y, obj_menu_button);
if(button != noone && button.active == true){
	sprite_index = spr_mouse_hovering;
}
if(item != noone){
	sprite_index = spr_mouse_grabbing;
}

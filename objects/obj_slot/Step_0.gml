/// @description Insert description here
// You can write your code in this editor
previous_hovered = hovered;
if (obj_mouse_cursor.item != noone) {
	var mouse_index = obj_mouse_cursor.item.index;
	var grid_width = obj_item_handler.grid_width;

	// Vertical and same cell
	if (
		mouse_index == index + grid_width || 
		mouse_index == index - grid_width ||
		mouse_index == index
	) {
		hovered = position_meeting(mouse_x, mouse_y, id);
	}

	// Right (mouse is to the right of this cell)
	else if ((mouse_index == index + 1) && (index div grid_width == mouse_index div grid_width)) {
		hovered = position_meeting(mouse_x, mouse_y, id);
	}

	// Left (mouse is to the left of this cell)
	else if ((mouse_index == index - 1) && (index div grid_width == mouse_index div grid_width)) {
		hovered = position_meeting(mouse_x, mouse_y, id);
	}
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
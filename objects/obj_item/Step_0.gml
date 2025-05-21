/// @description Insert description here
// You can write your code in this editor
move_to_target_position();
// Start dragging
if (!dragging && mouse_check_button_pressed(mb_left) && collision_point(mouse_x, mouse_y, id, false, false)) {
    dragging = true;
    obj_mouse_cursor.item = id;
	layer = layer_get_id(LAYER_MOUSE);
}

// While dragging
if (dragging) {
	// move to mouse posiiton first.
    x = mouse_x;
    y = mouse_y;

    // then check if we are not supposed to be dragged anymore.
	// removing mouse follow and release bug.
    if (mouse_check_button_released(mb_left)) {
        dragging = false;
        obj_mouse_cursor.item = noone;
		// layer = LAYER_ITEMS;
	    layer = layer_get_id(LAYER_ITEMS);
        // Place item, trigger event, etc.
    }
}
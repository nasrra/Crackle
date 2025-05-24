/// @description Insert description here
// You can write your code in this editor
move_to_target_position();
// Start dragging
target_scale = 1;
if (obj_item_handler.items_are_grabbable == true && is_grabbable == true && !grabbing && collision_point(mouse_x, mouse_y, id, false, false)) {
    if(mouse_check_button_pressed(mb_left)){
		grabbing = true;
		obj_mouse_cursor.item = id;
		layer = layer_get_id(LAYER_MOUSE);
	}
	if(obj_mouse_cursor.item == noone){
		target_scale = 1.25;
	}
}

// While dragging
if (grabbing) {
	// move to mouse posiiton first.
    x = mouse_x;
    y = mouse_y;
	target_scale = 1.3;
    // then check if we are not supposed to be dragged anymore.
	// removing mouse follow and release bug.
    if (mouse_check_button_released(mb_left)) {
        grabbing = false;
		// layer = LAYER_ITEMS;
	    layer = layer_get_id(LAYER_ITEMS);
        // Place item, trigger event, etc.
    }
}

image_yscale = lerp(image_yscale, target_scale, 0.33);
image_xscale = lerp(image_xscale, target_scale, 0.33);
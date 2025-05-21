/// @description Insert description here
// You can write your code in this editor
move_to_target_position();
// Start dragging
if (!dragging && mouse_check_button_pressed(mb_left) && collision_point(mouse_x, mouse_y, id, false, false)) {
    dragging = true;
    global.mouse_has_item = true;
}

// While dragging
if (dragging) {
    x = mouse_x;
    y = mouse_y;

    // Stop dragging
    if (mouse_check_button_released(mb_left)) {
        dragging = false;
        global.mouse_has_item = false;
        // Place item, trigger event, etc.
    }
}
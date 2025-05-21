/// @description Item Create Event
index           = undefined;
slot            = undefined;
target  = undefined;
idle_move_speed = 0.1;
mouse_move_speed = 1;
move_speed = idle_move_speed;
dragging = false;

function move_to_target_position(){
    if(target = undefined){
        exit;
    }
    x = lerp(x, target.x, move_speed);
    y = lerp(y, target.y, move_speed);
}

function queue_removal(){
    obj_item_handler.remove_item(index);
}
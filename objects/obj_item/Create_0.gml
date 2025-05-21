/// @description Item Create Event
index         = undefined;
target        = undefined;

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
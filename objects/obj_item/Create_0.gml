/// @description Item Create Event
index           = undefined;
slot            = undefined;
target          = undefined;
position_x_offset = 0;
position_y_offset = 0;
idle_move_speed = 0.1;
mouse_move_speed = 1;
move_speed = idle_move_speed;
grabbing = false;
item_id = undefined;

function move_to_target_position(){
    if(target = undefined){
        exit;
    }
    x = lerp(x, target.x + position_x_offset, move_speed);
    y = lerp(y, target.y + position_y_offset, move_speed);
}

function smooth_destroy(time_in_frames){
	alarm_set(0, time_in_frames);
}
target          = obj_camera_target;

// 480p for pixel art stuff.
camera_width       = 960;
camera_height      = 540;

smooth_factor   = 0.1;

previous_x = target.y;
previous_y = target.x;
target_x = target.x;
target_y = target.y;

offset_x = 0;
offset_y = 0;

function update_position(){
    if(instance_exists(target)==false){
        exit; // return but for gml.
    }

    // set position to centre in on the target.
    target_x = target.x - (camera_width * 0.5);
    target_y = target.y - (camera_height * 0.5);

    // add offset.
    target_x += offset_x;
    target_y += offset_y;

    // clamp the x and y of the camera so it desnt go outside of the room.
    // target_x = clamp(target_x, 0, room_width - camera_width);
    // target_y = clamp(target_y, 0, room_height - camera_height);

    // lerp to desired position.
    target_x = lerp(previous_x, target_x, smooth_factor);
    target_y = lerp(previous_y, target_y, smooth_factor);
    previous_x = target_x;
    previous_y = target_y;
    
    camera_set_view_pos(view_camera[0], target_x, target_y);
}

function snap_to_target(){
    var _smooth_factor = smooth_factor;
    smooth_factor = 1;
    update_position(); // here for the room bounds check.
    smooth_factor = _smooth_factor;
}

function handle_input(){
    if(keyboard_check_pressed(vk_alt)){
        shake_camera(33,1,6);
    }
}


shake_amount        = undefined //75;
shake_count         = undefined //0;
shake_rate          = undefined //1;
shake_alarm_index   = 0;
function shake_camera(_amount, _rate, _count){
    shake_amount    = _amount;
    shake_count     = _count;
    shake_rate      = _rate;
    alarm_set(shake_alarm_index, 1);
}

function _shake_camera(){
    if(shake_count > 0){
        shake_count -= 1;
        offset_x = random_range(-shake_amount, shake_amount);
        offset_y = random_range(-shake_amount, shake_amount);
        alarm_set(shake_alarm_index, shake_rate);
    }
    else{
        offset_x = 0;
        offset_y = 0;
    }
}



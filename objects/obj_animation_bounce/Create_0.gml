/// @description Insert description here
// You can write your code in this editor
state           = AnimationBounceState.NONE;
scale           = undefined;
max_scale       = undefined;
min_scale       = undefined;
target_scale    = undefined;
frame_change    = undefined;
lerp_speed      = undefined;
max_cycles      = undefined;
current_cycle   = 0;
current_frame   = 0;

smooth_destroy_alarm_index  = 0;
loop_alarm_index            = 1;
loop_cycled_alarm_index     = 2;

function initialise(_scale, _max_scale, _min_scale, _frame_change, _lerp_speed){
    scale           = _scale;
    max_scale       = _max_scale;
    min_scale       = _min_scale;
    frame_change    = _frame_change;
    lerp_speed      = _lerp_speed;
}

function reset_variables(){
    scale           = undefined;
    max_scale       = undefined;
    min_scale       = undefined;
    frame_change    = undefined;
    lerp_speed      = undefined;
    max_cycles      = undefined;
    current_cycle   = 0;
    current_frame   = 0;
}

function start_bounce_from_zero(){
    current_frame = 0;
    state = AnimationBounceState.ENLARGE;
    scale = 0;
    _set_target_scale();
    alarm_set(loop_alarm_index,1);
}

function start_bounce_loop(){
    current_frame = 0;
    state = AnimationBounceState.ENLARGE;
    scale = min_scale;
    _set_target_scale();
    alarm_set(loop_alarm_index,1);
}


function start_bounce_to_zero(){
    current_frame = 0;
    state = AnimationBounceState.ZERO;
    _set_target_scale();
    alarm_set(loop_alarm_index,0);
    alarm_set(loop_alarm_index,1);
}

function _loop(){
    if(current_frame == frame_change){
        if(state == AnimationBounceState.ENLARGE){
            state = AnimationBounceState.SHRINK;
        }
        else if(state == AnimationBounceState.SHRINK){
            state = AnimationBounceState.ENLARGE;
        }
        _set_target_scale();
        current_frame = 0;
    }
    current_frame++;
    scale = lerp(scale, target_scale, lerp_speed);
    alarm_set(loop_alarm_index,1);
}

function _loop_cycled(){
    if(current_cycle == max_cycles){
        current_frame = 0;
        current_cycle = 0;
        exit;
    }

    if(current_frame == frame_change){
        state = state == AnimationBounceState.ENLARGE? AnimationBounceState.SHRINK : AnimationBounceState.ENLARGE;
        _set_target_scale();
        current_frame = 0;
        current_cycle++;
    }
    current_frame++;
    scale = lerp(scale, target_scale, lerp_speed);
    alarm_set(loop_cycled_alarm_index,1);
}

function _set_target_scale(){
    switch(state){
        case AnimationBounceState.ENLARGE:
            target_scale = max_scale;
            break;
        case AnimationBounceState.SHRINK:
            target_scale = min_scale;
            break;
        case AnimationBounceState.ZERO:
            target_scale = 0;
            break;
        case AnimationBounceState.NONE:
            target_scale = scale;
            break;
    }
}

enum AnimationBounceState{
	ENLARGE,
	SHRINK,
	ZERO,
	NONE,
}
/// @description Insert description here
// You can write your code in this editor
previous_hovered = false;
hovered = false;

row = undefined;
item = noone;

scored = false;
scored_this_frame = false;

scale = 1;
target_scale = 1;
scale_lerp_speed = 0.33;

function initialise(){
	scored_particle = instance_create_layer(x, y, LAYER_PARTICLES, obj_particle_system);
	scored_particle.initialise(part_type_slot_scored(), 0, 0);
	scored_particle.x = x;
	scored_particle.y = y;
}

function score(){
	score_state();
}

function hover_state(){
	target_scale = 1.15; 
	scale_lerp_speed = 0.33;
}

function idle_state(){
	if(scored == true){
		exit;
	}
	target_scale = 1;
	scale_lerp_speed = 0.33;
}

function score_state(){
	if(scored_this_frame == true){
		show_debug_message("double scored!");
	}
	scored_this_frame = true;
	scored = true;
	scored_particle.emit(20);
	target_scale = 1.25; 
	scale_lerp_speed = 0.33;
	alarm_set(0,10);
}

function handle_scale(){
	scale = lerp(scale, target_scale, scale_lerp_speed);
}

idle_state();
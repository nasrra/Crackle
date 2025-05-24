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

index = undefined;

function initialise(_index){
	scored_particle = instance_create_layer(x, y, LAYER_PARTICLES, obj_particle_system);
	scored_particle.initialise(part_type_slot_scored(), 0, 0);
	scored_particle.x = x;
	scored_particle.y = y;
	index = _index;
}

function score(amount){
	score_state(amount);
}

function hover_state(){
	target_scale = 1.2; 
	scale_lerp_speed = 0.33;
}

function idle_state(){
	if(scored == true){
		exit;
	}
	target_scale = 1;
	scale_lerp_speed = 0.33;
}

function score_state(amount){
	if(scored_this_frame == true){
		show_debug_message("double scored!");
	}
	scored_this_frame = true;
	scored = true;
	scored_particle.emit(20);
	target_scale = 1.25; 
	scale_lerp_speed = 0.33;
	var score_text = instance_create_layer((x-16),(y-8),LAYER_TEXT,obj_text_wave); 
	score_text.initialise(string(amount), 2, 0, true);
	score_text.start_lifetime_timer(45);
	// obj_text_manager.add_world_space_text(score_text);
	alarm_set(0,10);
}

function handle_scale(){
	scale = lerp(scale, target_scale, scale_lerp_speed);
}

function clear(){
	instance_destroy(item);
	item = noone;
}

idle_state();
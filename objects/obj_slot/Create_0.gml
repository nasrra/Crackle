/// @description Insert description here
// You can write your code in this editor
previous_hovered = false;
hovered = false;
scale = 1;
idle_scale = 1;
hover_scale = 1.25;
row = undefined;
item = noone;
scored = false;
scored_this_frame = false;


function initialise(){
	scored_particle = instance_create_layer(x, y, LAYER_PARTICLES, obj_particle_system);
	scored_particle.initialise(part_type_slot_scored(), 0, 0);
	scored_particle.x = x;
	scored_particle.y = y;
}

function score(){
	if(scored_this_frame == true){
		show_debug_message("double scored!");
	}

	scored_this_frame = true;
	scored = true;
	scored_particle.emit(20);
	alarm_set(0,120);
}
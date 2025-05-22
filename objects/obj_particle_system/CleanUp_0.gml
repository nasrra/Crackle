/// @description Insert description here
// You can write your code in this editor
if(particle_system != undefined){
	stop_stream();
	emitter = undefined;
	part_emitter_destroy_all(particle_system);
	part_type_destroy(particle_type);
	part_system_destroy(particle_system);
}
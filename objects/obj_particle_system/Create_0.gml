/// @description Insert description here
// You can write your code in this editor
particle_system             = undefined;
particle_type               = undefined;
emitter                     = undefined;
emitter_region_right_offset = 0;
emitter_region_top_offset   = 0;
lock_emitter_position       = false;

function update_emitter_position(){
    if(particle_system == undefined || lock_emitter_position == true){
        exit;
    }
    part_emitter_region(
        particle_system, 
        emitter, 
        x,
        x+emitter_region_right_offset,
        y+emitter_region_top_offset,
        y, 
        ps_shape_ellipse, 
        ps_distr_linear
    );
}

function initialise(_particle_type, _emitter_region_right_offset, _emitter_region_top_offset){
    // // refresh particle system.
    // if(particle_system != undefined){
    //     // wipe this one for reuse;
    //     emitter = undefined;
    //     part_emitter_destroy_all(particle_system);
    //     part_type_destroy(particle_type);
    //     part_system_destroy(particle_system);
    // }
    particle_system = part_system_create();
    particle_type = _particle_type;
    emitter = part_emitter_create(particle_system);
    emitter_region_right_offset = _emitter_region_right_offset; 
    emitter_region_top_offset = _emitter_region_top_offset;
}

function start_stream(_amount){
	part_emitter_stream(particle_system, emitter, particle_type, _amount);
}

function stop_stream(){
	part_emitter_stream(particle_system, emitter, particle_type, 0);
}

function smooth_destroy(_smooth_destroy_time){
    stop_stream();
    alarm_set(0,_smooth_destroy_time);
}

function emit(_amount){
    part_particles_create(particle_system, x, y, particle_type, _amount);
}

function emit_one_shot(_amount, _smooth_destroy_time){
    emit(_amount);
    alarm_set(0,_smooth_destroy_time);
}

function set_emission_angle(_min, _max){
    part_type_direction(particle_type, _min, _max, 0, 0);
}

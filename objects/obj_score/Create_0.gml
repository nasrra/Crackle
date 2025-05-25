/// @description Insert description here
// You can write your code in this editor

score_value = 0;
value_string = "000000";

text = instance_create_layer(x,y,LAYER_TEXT, obj_text_wave);
text.layer_rotate_speed = 0.25;
text.initialise("Score: "+value_string, 1, 0, true);
text.set_bounce(2, 0.85, 120, 0.01);

particle_1 = instance_create_layer(x, y, LAYER_PARTICLES, obj_particle_system);
particle_1.initialise(part_type_slot_scored(), 0, 0);
particle_1.x = x+16;
particle_1.y = y;

particle_2 = instance_create_layer(x, y, LAYER_PARTICLES, obj_particle_system);
particle_2.initialise(part_type_slot_scored(), 0, 0);
particle_2.x = x+200;
particle_2.y = y;


function add_value(amount){
    score_value += amount;
    value_string = string(score_value);
    while (string_length(value_string) < 6) {
        value_string = "0" + value_string;
    }
    obj_moves.add_value(amount%1)
    if(amount > 0){
        particle_1.emit(20);
        particle_2.emit(20);
    }
}
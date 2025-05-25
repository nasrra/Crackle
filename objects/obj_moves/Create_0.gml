/// @description Insert description here
// You can write your code in this editor

total_moves = 0;
moves_value = 12;
value_string = "0012";
// starting_moves_amount = 12;

text = instance_create_layer(x,y,LAYER_TEXT, obj_text_wave);
text.layer_rotate_speed = 0.25;
text.initialise("TURNS: "+value_string, 1, 0, true);
text.set_bounce(2, 0.85, 120, 0.01);

particle_1 = instance_create_layer(x, y, LAYER_PARTICLES, obj_particle_system);
particle_1.initialise(part_type_slot_scored(), 0, 0);
particle_1.x = x+16;
particle_1.y = y;

particle_2 = instance_create_layer(x, y, LAYER_PARTICLES, obj_particle_system);
particle_2.initialise(part_type_slot_scored(), 0, 0);
particle_2.x = x+164;
particle_2.y = y;

move_gained_this_frame = false;


function add_value(amount){
    moves_value += amount;
    value_string = string(moves_value);
    while (string_length(value_string) < 4) {
        value_string = "0" + value_string;
    }
    if(amount > 0){
        if(move_gained_this_frame == false){
            particle_1.emit(20);
            particle_2.emit(20);
            audiomanager_play_turn_gained();
        }
        move_gained_this_frame = true;
    }
    else if(amount < 0){
        total_moves += -amount;
    }
}

// add_value(starting_moves_amount);
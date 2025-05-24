/// @description Insert description here
// You can write your code in this editor

score_value = 0;
value_string = "000000";

text = instance_create_layer(x,y,LAYER_TEXT, obj_text_wave);
text.layer_rotate_speed = 0.25;
text.initialise("Score: "+value_string, 1, 0, true);
text.set_bounce(2, 0.75, 120, 0.01);


function add_value(amount){
    score_value += amount;
    value_string = string(score_value);
    while (string_length(value_string) < 6) {
        value_string = "0" + value_string;
    }
    obj_moves.add_value(amount%1)
    // show_debug_message(value_string);
}
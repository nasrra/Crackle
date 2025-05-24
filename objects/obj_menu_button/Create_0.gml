/// @description Insert description here
// You can write your code in this editor
text = instance_create_layer(x+text_offset_x,y+text_offset_y, LAYER_MENU_TEXT, obj_text_wave);
text.initialise_ext(text_text, text_scale, 0, true, 120, 0.005, 0.25);
text.bounce.start_bounce_loop();

on_press = undefined;
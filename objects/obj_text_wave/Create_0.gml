/// @description Insert description here
// You can write your code in this editor
event_inherited();

layers = 10;
layers_radius_additive = 0.33;
layers_angle = 0;
bounce = noone;
function initialise(_text, _scale, _angle, _world_space){
    base_initialise(_text, _scale, _angle, _world_space);
    bounce = instance_create_layer(0,0,layer,obj_animation_bounce);
    bounce.initialise(scale, scale, scale*bounce_factor, 30, 0.05);
    bounce.start_bounce_from_zero();
	show_debug_message(string_join(" ", "BOUNCE:", bounce));
    scale = 0;
}

if(initialise_on_create == true){
	initialise(text, scale, angle, world_space);
}

function draw(){
    var lerp_factor = 1/layers;
    draw_set_font(font_wave);
    for(var i = 0; i < layers; i++){
        var _x = lengthdir_x(layers_radius_additive*i*scale, layers_angle) + draw_x_position;
        var _y = lengthdir_y(layers_radius_additive*i*scale, layers_angle) + draw_y_position;
        // draw_set_color(c_black);
        // draw_text_transformed(_x-((outline_scale-scale)*24), _y-((outline_scale-scale)*12), text, outline_scale, outline_scale+(outline_scale-scale), angle);
        draw_set_color(lerp_colour(start_colour, end_colour, lerp_factor*i));
        draw_text_transformed(_x, _y, text, scale, scale, angle);
    }
    draw_set_color(c_white);
    layers_angle += 8;
}
on_lifetime_end.set(function(){
    start_destroy_timer(120);
    bounce.start_bounce_to_zero();
});
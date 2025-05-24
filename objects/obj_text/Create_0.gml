/// @description Insert description here
// You can write your code in this editor

on_lifetime_end = new EventAction();
draw_x_position = undefined;
draw_y_position = undefined;

function base_initialise(_text, _scale, _angle, _world_space){
    text = _text;
    scale = _scale;
    angle = _angle;
	world_space = _world_space;
	// if(_world_space==true){
	// 	obj_text_manager.add_world_space_text(id);
	// }
	// else{
	// 	obj_text_manager.add_screen_space_text(id);
	// }
}

function initialise(_text, _scale, _angle, _world_space){
	base_initialise(_text, _scale, _angle, _world_space);
}

function start_destroy_timer(_time_in_frames){
    alarm_set(0,_time_in_frames);
}

function start_lifetime_timer(_time_in_frames){
    alarm_set(1,_time_in_frames);
}

function draw_in_screen_space(){
    draw_x_position = texthelper_get_gui_center_x(text, scale) + draw_x_offset;
    draw_y_position = texthelper_get_gui_center_y(text, scale) + draw_y_offset;
    draw();
}

function draw_in_world_space(){
    draw_x_position = x;
    draw_y_position = y;
    draw();
}
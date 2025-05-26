/// @description Insert description here
// You can write your code in this editor
if(position_meeting(mouse_x, mouse_y, id)){
    target_scale = 1.2;
    if(mouse_check_button_pressed(mb_left) == true){
        if(on_press != undefined){
			on_press();
		}
		if(on_press_ext != undefined){
			on_press_ext();
		}
    }
}
else{
    target_scale = 1;
}

// text.image_xscale = lerp(text.image_xscale, text.scale * target_scale, 0.33);
// text.image_yscale = lerp(text.image_yscale, text.scale * target_scale, 0.33);
image_xscale = lerp(image_xscale, target_scale * button_scale_x, 0.33);
image_yscale = lerp(image_yscale, target_scale * button_scale_y, 0.33);
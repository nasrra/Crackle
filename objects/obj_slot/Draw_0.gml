/// @description Insert description here
// You can write your code in this editor
if(hovered == false){
    scale = lerp(scale, idle_scale, 0.33);
}
else{
    scale = lerp(scale, hover_scale, 0.33);    
}

var colour = scored == true? c_green : c_white;
draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, image_angle, colour, 1);
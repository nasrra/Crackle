function part_type_slot_scored(){
    var _type = part_type_create();

    part_type_shape(_type, pt_shape_square);  
    part_type_color3(_type, make_colour_rgb(0,255,148), c_white, c_white);
    part_type_alpha3(_type, 1, 0.75, 0);
    part_type_scale(_type, 0.1, 0.12);
    part_type_size(_type, 1.0, 1.0, -0.02, 0.25);
    part_type_speed(_type,1.0, 3.0,-0.1,0);
    part_type_direction(_type, 0, 360, 0, 0);
    part_type_orientation(_type, 0, 360, 0, 0.0, true);
    part_type_life(_type, 40, 60);

    return _type;
}
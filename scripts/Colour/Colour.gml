#macro c_fire_light         c_orange
#macro c_fire               c_red
#macro c_electric_light     make_colour_rgb(0,246,255)
#macro c_electric           make_colour_rgb(0,123,255)
#macro c_electric_dark      c_blue

function lerp_colour(_colour_1, _colour_2, _amount) {
    var r1 = color_get_red(_colour_1);
    var g1 = color_get_green(_colour_1);
    var b1 = color_get_blue(_colour_1);

    var r2 = color_get_red(_colour_2);
    var g2 = color_get_green(_colour_2);
    var b2 = color_get_blue(_colour_2);

    var r = lerp(r1, r2, _amount);
    var g = lerp(g1, g2, _amount);
    var b = lerp(b1, b2, _amount);

    return make_color_rgb(r, g, b);
}
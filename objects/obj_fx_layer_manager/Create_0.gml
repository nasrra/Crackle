




// GENERIC.

function handle_value(_val_string, _target_val, _speed, _alarm_index, _fx){
    var val = fx_get_parameter(_fx, _val_string);
    var calc_val = lerp(val, _target_val, _speed);
    val = abs(val-_target_val) < 0.025 ? _target_val : calc_val;
    fx_set_parameter(_fx, _val_string, val);
    if(val != _target_val){
        alarm_set(_alarm_index, 1);
    }
}

function _handle_values(_fx, _alarm_index, _val_strings, _target_vals, _transition_speeds){
    loop = false;
    for(var i = 0; i < array_length(_val_strings); i++){
        var val_string = _val_strings[i]
        var val = fx_get_parameter(_fx,_val_strings[i]);
        var target_val = _target_vals[i];
        var transition_speed  = _transition_speeds[i];

        var calc_val = lerp(val, target_val, transition_speed);
        val = abs(val - target_val) < 0.025 ? target_val : calc_val;
        fx_set_parameter(_fx, val_string, val);
        if(val != target_val){
            loop = true;
        }
    }
    if(loop == true){
        alarm_set(_alarm_index, 1);
    }
}

function _handle_values_array(_fx, _alarm_index, _val_strings, _target_vals, _transition_speeds){
    loop = false;
    for(var i1 = 0; i1 < array_length(_val_strings); i1++){
        var val_string = _val_strings[i1]
        var val_array = fx_get_parameter(_fx,val_string);
        var target_val_array = _target_vals[i1];
        var transition_speed  = _transition_speeds[i1];

        for(var i2 = 0; i2 < array_length(val_array); i2++){
            var val = val_array[i2];
            var target_val = target_val_array[i2];
            var calc_val = lerp(val, target_val, transition_speed);
            val_array[i2] = abs(val - target_val) < 0.025 ? target_val : calc_val;
            if(val != target_val){
                loop = true;
            }
        }
        
        fx_set_parameter(_fx, val_string, val_array);
    }
    if(loop == true){
        alarm_set(_alarm_index, 1);
    }
}




// DESATURATE.

desaturate_alarm_index = 0;
desaturate_target_intensity = undefined;
desaturate_speed = undefined;
desaturate_fx = layer_get_fx("DesaturateFX");

function reset_desaturuate(){
    layer_set_visible("DesaturateFX", true);
    fx_set_parameter(desaturate_fx,"g_Intensity", 0);
}

function turn_on_desaturate(_speed){
    desaturate_speed = _speed;
    desaturate_target_intensity = 0.75;
    alarm_set(desaturate_alarm_index, 1);
}

function handle_desaturate(){
    handle_value("g_Intensity", desaturate_target_intensity, desaturate_speed, desaturate_alarm_index, desaturate_fx);
}

function turn_off_desaturate(_speed){
    desaturate_target_intensity = 0;
    alarm_set(desaturate_alarm_index, 1);
}

// reset_desaturuate();



// VIGNETTE.

vignette_alarm_index = 1;
vignette_target_edge_1 = undefined;
vignette_speed = undefined;
vignette_fx = layer_get_fx("VignetteFX");

function reset_vignette(){
    layer_set_visible("VignetteFX", true);
    fx_set_parameter(vignette_fx,"g_VignetteEdges", [1.25,1.25]);
    fx_set_parameter(vignette_fx,"g_VignetteSharpness", 2);
}
// reset_vignette();

function turn_on_vignette(_speed){
    vignette_speed = _speed;
    vignette_target_edge_1 = 0.75;
    alarm_set(vignette_alarm_index, 1);
}

function handle_vignette(){
    var val_array = fx_get_parameter(vignette_fx, "g_VignetteEdges");
    var val = val_array[0];
    var calc_val = lerp(val, vignette_target_edge_1, vignette_speed);
    val_array[0] = abs(val-vignette_target_edge_1) < 0.1? vignette_target_edge_1 : calc_val;
    fx_set_parameter(vignette_fx, "g_VignetteEdges", val_array);
    if(val != vignette_target_edge_1){
        alarm_set(vignette_alarm_index, 1);
    }
}

function turn_off_vignette(_speed){
    vignette_speed = _speed;
    vignette_target_edge_1 = 1.25;
    alarm_set(vignette_alarm_index, 1);
}





// RGB NOISE.

rgb_noise_alarm_index = 2;
rgb_noise_target_intensity = undefined;
rgb_noise_speed = undefined;
rgb_noise_fx = layer_get_fx("RGBNoiseFX");

function reset_rgb_noise(){
    layer_set_visible("RGBNoiseFX", true);
    fx_set_parameter(rgb_noise_fx, "g_RGBNoiseIntensity", 0);
    fx_set_parameter(rgb_noise_fx, "g_RGBNoiseAnimation", 0.001);
}
// reset_rgb_noise();

function turn_on_rgb_noise(_speed){
    rgb_noise_speed = _speed;
    rgb_noise_target_intensity = 0.15;
    alarm_set(rgb_noise_alarm_index, 1);
}

function handle_rgb_noise(){
    handle_value("g_RGBNoiseIntensity", rgb_noise_target_intensity, rgb_noise_speed, rgb_noise_alarm_index, rgb_noise_fx);
}

function turn_off_rgb_noise(_speed){
    rgb_noise_speed = _speed;
    rgb_noise_target_intensity = 0;
    alarm_set(rgb_noise_alarm_index, 1);
}





// // OldFilm / Fliker

old_film_alarm_index = 3;
old_film_fx = layer_get_fx("OldFilmFX");

function reset_old_film(){
    layer_set_visible("OldFilmFX", true);
    fx_set_parameter(old_film_fx, "g_OldFilmFlickerIntensity", 0); // .33
    fx_set_parameter(old_film_fx, "g_OldFilmFlickerSpeed", 0); // 15
    fx_set_parameter(old_film_fx, "g_OldFilmJitterIntensity", 1);
    fx_set_parameter(old_film_fx, "g_OldFilmSaturation", 1);
    fx_set_parameter(old_film_fx, "g_OldFilmSpeckIntensity", 0);
    fx_set_parameter(old_film_fx, "g_OldFilmBarScale", 0); // 20
    fx_set_parameter(old_film_fx, "g_OldFilmBarSpeed", 0); // 20
    fx_set_parameter(old_film_fx, "g_OldFilmBarFrequency",128); // 4
    fx_set_parameter(old_film_fx, "g_OldFilmRingScale", 0);
    fx_set_parameter(old_film_fx, "g_OldFilmRingSharpness", 0);
    fx_set_parameter(old_film_fx, "g_OldFilmRingIntensity", 0);
}

reset_old_film();





// Heat Haze.

heat_haze_alarm_index = 4;
heat_haze_fx = layer_get_fx("HeatHazeFX");
heat_haze_target_amount = undefined;
heat_haze_transition_speed = undefined;

function reset_heat_haze(){
    layer_set_visible("HeatHazeFX", true);
    fx_set_parameter(heat_haze_fx, "g_Distort1Speed", 0.05);
    fx_set_parameter(heat_haze_fx, "g_Distort2Speed", 0.05);
    fx_set_parameter(heat_haze_fx, "g_Distort1Scale", [50,25]);
    fx_set_parameter(heat_haze_fx, "g_Distort2Scale", [25,50]);
    fx_set_parameter(heat_haze_fx, "g_Distort1Amount", 0.55);
    fx_set_parameter(heat_haze_fx, "g_Distort2Amount", 0.55);
    fx_set_parameter(heat_haze_fx, "g_ChromaSpreadAmount", 10);
    fx_set_parameter(heat_haze_fx, "g_CamOffsetScale", 0);
}

reset_heat_haze();

function turn_on_heat_haze(_speed){
    heat_haze_transition_speed = _speed;
    heat_haze_target_amount = 2;
    alarm_set(heat_haze_alarm_index,1);
}

function _handle_heat_haze(){
    _handle_values(
        heat_haze_fx,
        heat_haze_alarm_index, 
        [
            "g_Distort1Amount",
            "g_Distort2Amount",
        ], 
        [
            heat_haze_target_amount,
            heat_haze_target_amount
        ],
        [
            heat_haze_transition_speed,
            heat_haze_transition_speed,
        ]
    );
}

function turn_off_heat_haze(_speed){
    heat_haze_transition_speed = _speed;
    heat_haze_target_amount = 0;
    alarm_set(heat_haze_alarm_index,1);
}





// Zoom Blur

zoom_blur_alarm_index = 5;
zoom_blur_fx = layer_get_fx("ZoomBlurFX");

function reset_zoom_blur(){
    layer_set_visible("ZoomBlurFX", true);
    fx_set_parameter(zoom_blur_fx, "g_ZoomBlurCenter", [0.5, 0.5]);     // g_ZoomBlurCenter (Array)
    fx_set_parameter(zoom_blur_fx, "g_ZoomBlurIntensity", 0.01);        // g_ZoomBlurIntensity (Real)
    fx_set_parameter(zoom_blur_fx, "g_ZoomBlurFocusRadius", 0);         // g_ZoomBlurFocusRadius (Real)   
}

reset_zoom_blur();
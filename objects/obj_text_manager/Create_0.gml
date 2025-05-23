/// @description Insert description here
// You can write your code in this editor

screen_space_text = ds_map_create();
world_space_text = ds_map_create();


function add_world_space_text(_id){
    ds_map_add(world_space_text, _id, true);
    // show_debug_message(string_join(" ","[+]world_space_text:", ds_map_size(world_space_text)));
    return array_length(world_space_text) - 1;
}

function add_screen_space_text(_id){
    ds_map_add(screen_space_text, _id, true);
    // show_debug_message(string_join(" ","[+]screen_space_text:", ds_map_size(screen_space_text)));
    return array_length(screen_space_text) - 1;
}

function remove_world_space_text(_id){
    ds_map_delete(world_space_text, _id);
    // show_debug_message(string_join(" ","[-]world_space_text:", ds_map_size(world_space_text)));
}

function remove_screen_space_text(_id){
    ds_map_delete(screen_space_text, _id);
    // show_debug_message(string_join(" ","[-]screen_space_text:", ds_map_size(screen_space_text)));
}

function draw_world_space(){
    var instance = ds_map_find_first(world_space_text);
    while(instance != undefined){
        instance.draw_in_world_space();
        instance = ds_map_find_next(world_space_text, instance);
    }
}

function draw_screen_space(){
    var instance = ds_map_find_first(screen_space_text);
    while(instance != undefined){
        instance.draw_in_screen_space();
        instance = ds_map_find_next(screen_space_text, instance);
    }
}
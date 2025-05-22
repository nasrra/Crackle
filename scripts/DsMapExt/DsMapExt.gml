// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ds_map_merge(map_dest,map_source) {
    var key = ds_map_find_first(map_source);
    while (key != undefined) {
        var value = map_source[? key];
        map_dest[? key] = value; // Overwrites if key exists
        key = ds_map_find_next(map_source, key);
    }
}
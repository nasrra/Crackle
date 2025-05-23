/// @description Item Manager Create Event
grid = [];
grid_width = 4;
grid_height = 5;
slot_size = 32;
slot_padding = 24;
min_score_amt = 2;
items_are_grabbable = true;

function create_grid(){
    var index = 0;
    for(var i = 0; i < grid_height; i++){
        for(var j = 0; j < grid_width; j++){
            var slot = instance_create_layer(0,0,LAYER_SLOTS, obj_slot);
            slot.x = x + (slot_size+slot_padding + (slot_size+slot_padding) * j);
            slot.y = y + (slot_size+slot_padding + (slot_size+slot_padding) * i);
            slot.initialise(index);
            array_push(grid, slot);
            // var item = instance_create_layer(slot.x, slot.y, LAYER_ITEMS, get_random_item());
            var item = instance_create_layer(0, 0, LAYER_ITEMS, get_random_item());
            slot.item = item;
            slot.row = j;
            item.target = slot;
            item.slot = slot;
            item.index = index;
            index++;
        }
    }
}

function set_grid_item(item, index){
    grid[index] = item;
}

function get_random_item(){
    var r = irandom(3);
    switch(r){
        case 0:
            return obj_item_1;
        case 1:
            return obj_item_2;
        case 2:
            return obj_item_3;
        case 3:
            return obj_item_4;
    }

    score_grid();
}

function remove_item(index){
    var initial_slot = grid[index]; 
    instance_destroy(initial_slot.item);
    var above = index - grid_width;
    var removed = false;
    while(above >= 0){
        var current = above+grid_width;
        var current_slot = grid[current];
        var above_slot = grid[above];
        var above_item = above_slot.item;
        if(above_item != noone && instance_exists(above_item)){
            current_slot.item = above_item;
            above_item.index = current;
            above_item.target = current_slot;
            above_item.slot = current_slot;
            above_slot.item = noone;
            removed = true;
        }
        // show_debug_message(string(current) +" "+ string(initial_slot.row));
        above -= grid_width;
    }
    if(removed == true || (index >= 0 && index < grid_width)){
        insert_item_at_row(initial_slot.row);
    }

    alarm_set(0,65);
}

function insert_item_at_row(row){
    if(row < 0 || row > grid_width){
        show_error("Error: inserting item at row {" + string(row) + "} is not valid!", true);
    }
    var slot = grid[row];
    var item = instance_create_layer(slot.x, -100, LAYER_ITEMS, get_random_item());
    slot.item = item;
    item.target = slot;
    item.slot = slot;
    item.index = row;

    alarm_set(0,65);
}

function swap_slots(slotA, slotB) {
    slotA.idle_state();
    slotB.idle_state();
    // Swap the item references
    var temp_item = slotA.item;
    slotA.item = slotB.item;
    slotB.item = temp_item;

    // Reassign each item's slot reference (important for logic)
    slotA.item.slot = slotA;
    slotB.item.slot = slotB;

    // Optionally swap index and target too, if needed:
    var temp_index  = slotA.item.index;
    var temp_target = slotA.item.target;

    slotA.item.index = slotB.item.index;
    slotA.item.target = slotB.item.target;

    slotB.item.index = temp_index;
    slotB.item.target = temp_target;

    score_grid();
}

function score_grid(){

    items_are_grabbable = false;

    var full_fill_map = ds_map_create();

    for(var i = 0; i < array_length(grid); i++){
        var current_slot = grid[i];
        var current_id = current_slot.item.item_id;
        var scored_neighbours = ds_map_create();

        var left_fill_map       = ds_map_create();
        var right_fill_map      = ds_map_create();
        var up_fill_map         = ds_map_create();
        var down_fill_map       = ds_map_create();


        _flood_fill(i, left_fill_map, right_fill_map, up_fill_map, down_fill_map);
        if( ds_map_size(left_fill_map) >= min_score_amt  ||
            ds_map_size(right_fill_map) >= min_score_amt ||
            ds_map_size(up_fill_map) >= min_score_amt    ||
            ds_map_size(down_fill_map) >= min_score_amt){
            ds_map_merge(full_fill_map, left_fill_map);
            ds_map_merge(full_fill_map, right_fill_map);
            ds_map_merge(full_fill_map, up_fill_map);
            ds_map_merge(full_fill_map, down_fill_map);
        }

        ds_map_destroy(left_fill_map);
        ds_map_destroy(right_fill_map);
        ds_map_destroy(up_fill_map);
        ds_map_destroy(down_fill_map);
    }

    _score_fill_map(full_fill_map);
    ds_map_destroy(full_fill_map);
}

function _score_fill_map(fill_map){
    var key = ds_map_find_first(fill_map);
    if(key == undefined || key == noone){
        items_are_grabbable = true;
        exit;
    }
    else{
        while(key != undefined && key != noone){
            key.score();
            audiomanager_play_slot_scored();
            remove_item(key.item.index);
            key = ds_map_find_next(fill_map, key);
        }
        items_are_grabbable = false;
    }    
}

function _flood_fill(root_index, left_fill_map, right_fill_map, up_fill_map, down_fill_map){
    var root_slot = grid[root_index];
    var fill_index;

    // Left neighbor (only if not at start of row)
    if (root_index % grid_width != 0){
        fill_index = root_index - 1;
        if ((fill_index div grid_width) == (root_index div grid_width)){
            var left_slot = grid[fill_index];
            if(_fill_neighbour(root_slot, left_slot, left_fill_map, left_fill_map, right_fill_map, up_fill_map, down_fill_map)){
                _flood_fill(fill_index, left_fill_map, right_fill_map, up_fill_map, down_fill_map);
            }
        }
    }

    // Right neighbor (only if not at end of row)
    if ((root_index + 1) % grid_width != 0){
        fill_index = root_index + 1;
        if ((fill_index div grid_width) == (root_index div grid_width)){
            var right_slot = grid[fill_index];
            if(_fill_neighbour(root_slot, right_slot, right_fill_map, left_fill_map, right_fill_map, up_fill_map, down_fill_map)){
                _flood_fill(fill_index, left_fill_map, right_fill_map, up_fill_map, down_fill_map);
            }
        }
    }

    // Up neighbor
    if (root_index >= grid_width){
        fill_index = root_index - grid_width;
        var up_slot = grid[fill_index];
        if(_fill_neighbour(root_slot, up_slot, up_fill_map, left_fill_map, right_fill_map, up_fill_map, down_fill_map)){
            _flood_fill(fill_index, left_fill_map, right_fill_map, up_fill_map, down_fill_map);
        }
    }

    // Down neighbor
    if (root_index < array_length(grid) - grid_width){
        fill_index = root_index + grid_width;
        var down_slot = grid[fill_index];
        if(_fill_neighbour(root_slot, down_slot, down_fill_map, left_fill_map, right_fill_map, up_fill_map, down_fill_map)){
            _flood_fill(fill_index, left_fill_map, right_fill_map, up_fill_map, down_fill_map);
        }
    }
}


function _fill_neighbour(current, neighbour, map_to_assign, left_fill_map, right_fill_map, up_fill_map, down_fill_map){
    // if (!instance_exists(current) || !instance_exists(neighbour)) return false;
    // if (!instance_exists(current.item) || !instance_exists(neighbour.item)) return false;
    // if(ds_exists(scored_map, ds_type_map) == false) return false;

    if( neighbour.item.item_id == current.item.item_id &&
        ds_map_exists(left_fill_map, neighbour.id)  == false &&
        ds_map_exists(right_fill_map, neighbour.id) == false && 
        ds_map_exists(up_fill_map, neighbour.id)    == false && 
        ds_map_exists(down_fill_map, neighbour.id)  == false){
        ds_map_add(map_to_assign, neighbour.id, true);
        return true;
    }
    return false;
}

/// @description Item Manager Create Event
grid = [];
grid_width = 6;
grid_height = 5;
slot_size = 32;
slot_padding = 24;
min_score_amt = 2;
items_are_grabbable = true;

non_grabbable_item_random_counter = 0;

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
    var r = non_grabbable_item_random_counter >= 6? irandom(4) : irandom(3);
    non_grabbable_item_random_counter++;
    switch(r){
        case 0:
            return obj_item_1;
        case 1:
            return obj_item_2;
        case 2:
            return obj_item_3;
        case 3:
            return obj_item_4;
        case 4:
            non_grabbable_item_random_counter = 0;
            return obj_item_5;
    }

    score_grid();
}

function erase_item(index){
    var initial_slot = grid[index]; 
    instance_destroy(initial_slot.item);
    remove_item(index);
}

function remove_item(index){
    var initial_slot = grid[index]; 
    var removed = false;

    // Start checking from the slot above the one we're removing
    var current_index = index;
    var above_index = current_index - grid_width;

    while (above_index >= 0) {
        var current_slot = grid[current_index];
        var above_slot = grid[above_index];
        var above_item = above_slot.item;

        if (above_item != noone && instance_exists(above_item)) {
            // Move the item down
            current_slot.item = above_item;
            above_item.index = current_index;
            above_item.slot = current_slot;
            above_item.target = current_slot;
            above_slot.item = noone;
            removed = true;
        }

        current_index = above_index;
        above_index -= grid_width;
    }

    // Fill top row with a new item if any item was pulled down
    if (removed || (index >= 0 && index < grid_width)) {
        insert_item_at_row(initial_slot.row);
    }

    // Run "fall again" logic if a non-grabbable item landed in bottom row
    var bottom_index = grid_width * (grid_height - 1); // start of bottom row
    for (var i = bottom_index; i < grid_width * grid_height; i++) {
        var slot = grid[i];
        var itm = slot.item;
        if (itm != noone && !itm.is_grabbable) {
            remove_item(itm.index); // recursive only if necessary
            itm.target = itm.id;
            itm.position_y_offset += 100;
        }
    }

    alarm_set(0, 65);
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

function swap_slots_by_index(slotAIndex, slotBIndex){
    swap_slots(grid[slotAIndex, slotBIndex]);
}

// slotA is the slot with the item that needs to be swapped into SlotB.
// slotA is primary, slotB is secondary.

function swap_slots(slotA, slotB) {
    slotA.idle_state();
    slotB.idle_state();

    // Track which item is coming from A
    var itemA = slotA.item;
    var itemB = slotB.item;

    // Swap the item references
    slotA.item = itemB;
    slotB.item = itemA;

    // Update slot reference
    slotA.item.slot = slotA;
    slotB.item.slot = slotB;

    // Save indices/targets before overwriting
    var indexA = itemA.index;
    var targetA = itemA.target;
    var indexB = itemB.index;
    var targetB = itemB.target;

    // Set new index and targets
    itemA.index = indexB;
    itemA.target = targetB;

    itemB.index = indexA;
    itemB.target = targetA;

    // removal logic on the moved item
    if (!itemB.is_grabbable && itemB.index >= ((grid_width * grid_height) - grid_width)) {
        remove_item(itemB.index);
        itemB.target = itemB.id; 
        itemB.position_y_offset += 100;
    }

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
		var score_amount = 100;
		if(ds_map_size(fill_map) > 3){
			score_amount += (ds_map_size(fill_map)-3) * 50;
		}
		
        while(key != undefined && key != noone){
            key.score(score_amount);
            audiomanager_play_slot_scored();
            erase_item(key.item.index);
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
    if(neighbour.item.can_be_scored == false){
        return false;
    }

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

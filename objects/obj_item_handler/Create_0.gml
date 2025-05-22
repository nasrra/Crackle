/// @description Item Manager Create Event
grid = [];
grid_width = 6;
grid_height = 5;
slot_size = 32;
slot_padding = 24;

function create_grid(){
    var index = 0;
    for(var i = 0; i < grid_height; i++){
        for(var j = 0; j < grid_width; j++){
            var slot = instance_create_layer(0,0,LAYER_SLOTS, obj_slot);
            slot.x = x + (slot_size+slot_padding + (slot_size+slot_padding) * j);
            slot.y = y + (slot_size+slot_padding + (slot_size+slot_padding) * i);
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
        show_debug_message(string(current) +" "+ string(initial_slot.row));
        above -= grid_width;
    }
    if(removed == true || (index >= 0 && index < grid_width)){
        insert_item_at_row(initial_slot.row);
    }

    score_grid();
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

    score_grid();
}

function swap_slots(slotA, slotB) {
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
    for(var i = 0; i < array_length(grid); i++){
        var current_slot = grid[i];
        var current_id = current_slot.item.item_id;
        if(i % grid_width != 0){
            var left_slot = grid[i-1];
            if(left_slot.item.item_id == current_id){
                left_slot.score();
            }
            if(i < array_length(grid)-1){
                var right_slot = grid[i+1];
                if(right_slot.item.item_id == current_id){
                    right_slot.score();
                }
            }
        }
        if(i >= grid_width){
            var up_slot = grid[i-grid_width];
            if(up_slot.item.item_id == current_id){
                up_slot.score();
            }
        }
        if(i < array_length(grid) - grid_width){
            var bot_slot = grid[i+grid_width];
            if(bot_slot.item.item_id == current_id){
                bot_slot.score();
            }
        }
    }
}

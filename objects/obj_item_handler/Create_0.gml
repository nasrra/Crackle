/// @description Item Manager Create Event
function Slot(_x, _y) constructor{
    x = _x;
    y = _y;
    row = undefined;
    item = noone;
}

grid = [];
grid_length = 10;
grid_height = 5;
slot_size = 32;
slot_padding = 8;

function create_grid(){
    var index = 0;
    for(var i = 0; i < grid_height; i++){
        for(var j = 0; j < grid_length; j++){
            var slot = new Slot(
                x + (slot_size+slot_padding + (slot_size+slot_padding) * j),
                y + (slot_size+slot_padding + (slot_size+slot_padding) * i)
            );

            array_push(grid, slot);
            // var item = instance_create_layer(slot.x, slot.y, LAYER_ITEMS, get_random_item());
            var item = instance_create_layer(0, 0, LAYER_ITEMS, get_random_item());
            slot.item = item;
            slot.row = j;
            item.target = slot;
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
}

function remove_item(index){
    var initial_slot = grid[index]; 
    instance_destroy(initial_slot.item);
    var above = index - grid_length;
    var removed = false;
    while(above >= 0){
        var current_slot = grid[above+grid_length];
        var above_slot = grid[above];
        var above_item = above_slot.item;
        if(above_item != noone && instance_exists(above_item)){
            current_slot.item = above_item;
            above_item.index = above+grid_length;
            above_item.target = current_slot;
            above_slot.item = noone;
            removed = true;
        }
        show_debug_message(string(above+grid_length) +" "+ string(initial_slot.row));
        above -= grid_length;
    }
    if(removed == true || (index >= 0 && index < grid_length)){
        insert_item_at_row(initial_slot.row);
    }
}

function insert_item_at_row(row){
    if(row < 0 || row > grid_length){
        show_error("Error: inserting item at row {" + string(row) + "} is not valid!", true);
    }
    var slot = grid[row];
    var item = instance_create_layer(slot.x, -100, LAYER_ITEMS, get_random_item());
    slot.item = item;
    item.target = slot;
    item.index = row;
}
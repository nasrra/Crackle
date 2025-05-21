/// @description Insert description here
// You can write your code in this editor
function Slot(_x, _y) constructor{
    x = _x;
    y = _y;
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
            var item = instance_create_layer(slot.x, slot.y, LAYER_ITEMS, get_random_item());
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
/// @description Insert description here
// You can write your code in this editor

text1 = instance_create_layer(x+text_offset_x,y+text_offset_y, layer, obj_text_wave);
text1.initialise_ext("", text_scale, 0, true, 120, 0.005, 0.25);
text1.bounce.start_bounce_loop();


text2 = instance_create_layer(x+text_offset_x,y+text_offset_y+text_padding,layer, obj_text_wave);
text2.initialise_ext("", text_scale, 0, true, 120, 0.005, 0.25);
text2.bounce.start_bounce_loop();


text3 = instance_create_layer(x+text_offset_x,y+text_offset_y+text_padding*2, layer, obj_text_wave);
text3.initialise_ext("", text_scale, 0, true, 120, 0.005, 0.25);
text3.bounce.start_bounce_loop();

text4 = instance_create_layer(x+text_offset_x,y+text_offset_y+text_padding*3, layer, obj_text_wave);
text4.initialise_ext("", text_scale, 0, true, 120, 0.005, 0.25);
text4.bounce.start_bounce_loop();

text5 = instance_create_layer(x+text_offset_x,y+text_offset_y+text_padding*4, layer, obj_text_wave);
text5.initialise_ext("", text_scale, 0, true, 120, 0.005, 0.25);
text5.bounce.start_bounce_loop();

text6 = instance_create_layer(x+text_offset_x,y+text_offset_y+text_padding*5, layer, obj_text_wave);
text6.initialise_ext("", text_scale, 0, true, 120, 0.005, 0.25);
text6.bounce.start_bounce_loop();

show_debug_message("load");
root = "leaderboard";
listener = FirebaseFirestore(root).Listener();

data = -1;

sort_score = function(_a, _b){
    return _b.score - _a.score;
}

function evaluate_score(_name, _score){
    if(array_length(data) == 6){
        for(var i = 0; i < array_length(data); i++){
            if(data[i].score < _score){
                remove_highscore(i);
                add_highscore(_name, _score);
            }
        } 
    }else{
        add_highscore(_name, _score);
    }
}

function add_highscore(_name, _score){
    var _n = _name;
    while (string_length(_n) < 10) {
        _n = _n+" ";
    }

    var _s = _score;
    while (string_length(_s) < 6) {
        _s = "0"+string(_s);
    }


    var _doc = json_stringify(
	{
		name: _n,		
		score: _s
	}
    );
    FirebaseFirestore(root).Set(_doc);
}

function remove_highscore(index){
    if(data != -1 && array_length(data)>index){
        var _doc = FirebaseFirestore(root).Child(data[index].id);
        _doc.Delete();
    }
}

function remove_first_highscore(){
    var _doc = FirebaseFirestore(root).Child(data[0].id);
    _doc.Delete();
}

function set_text(){
    if(data == -1){
        text1.text = "Loading...";
        text2.text = "";
        text3.text = "";
    }
    else{
        for(var i = 0; i < 6; i++){
            if(i < array_length(data)){
                var _doc = data[i];
                if(i == 0){
                    text1.text = string_join(": ", _doc.name, _doc.score);
                }
                if(i == 1){
                    text2.text = string_join(": ", _doc.name, _doc.score);
                }
                if(i == 2){
                    text3.text = string_join(": ", _doc.name, _doc.score);
                }
                if(i == 3){
                    text4.text = string_join(": ", _doc.name, _doc.score);
                }
                if(i == 4){
                    text5.text = string_join(": ", _doc.name, _doc.score);
                }
                if(i == 5){
                    text6.text = string_join(": ", _doc.name, _doc.score);
                }
            }
            else{
                if(i == 0){
                    text1.text = "...";
                }
                if(i == 1){
                    text2.text = "...";
                }
                if(i == 2){
                    text3.text = "...";
                }
                if(i == 3){
                    text4.text = "...";
                }
                if(i == 4){
                    text5.text = "...";
                }
                if(i == 5){
                    text6.text = "...";
                }
            }
        }
    }
}
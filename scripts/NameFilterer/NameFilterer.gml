// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

global.bad_word_list = ds_list_create();

    global.bad_word_list = ds_list_create();

    if (file_exists("name_filter.txt")) {
        var file = file_text_open_read("name_filter.txt");

        if (file != -1) {
            while (!file_text_eof(file)) {
                var word = string_lower(string_trim(file_text_readln(file)));
                if (word != "") {
                    ds_list_add(global.bad_word_list, word);
                    // show_debug_message("Loaded word: " + word);
                }
            }
            file_text_close(file);
        } else {
            show_debug_message("Failed to open name_filter.txt");
        }
    } else {
        show_debug_message("name_filter.txt not found in Included Files");
    }

function namefilter_is_name_inappropriate(_name){
    var name = string_lower(_namefilter_sanitize_name(_name));

    for(var i = 0; i < ds_list_size(global.bad_word_list); i++){
        var word = global.bad_word_list[| i];
        if(string_pos(word, name) > 0){
            return true;
        }
    }
    return false;
}

function _namefilter_collapse_repeated_letters(_name){
    var result = "";
    var last_char = "";
    var len = string_length(_name);
    for(var i = 0; i <= len; i++){
        var char = string_char_at(_name, i);
        if(char != last_char){
            result += char;
            last_char = char;
        }
    }

    return result;
}

function _namefilter_sanitize_name(_name){
    _name = string_lower(_name);
    _name = string_replace_all(_name, "@", "a");
    _name = string_replace_all(_name, "1", "i");
    _name = string_replace_all(_name, "!", "i");
    _name = string_replace_all(_name, "$", "s");
    _name = string_replace_all(_name, "0", "o");
    _name = string_replace_all(_name, "3", "e");
    _name = string_replace_all(_name, "4", "a");
    _name = string_replace_all(_name, "|", "i");
    _name = string_replace_all(_name, "/", "i");
    _name = string_replace_all(_name, "\\", "i");
    _name = string_replace_all(_name, "/\\\\/", "n");
    _name = string_replace_all(_name, "/\\\\/\\", "m");
    _name = string_replace_all(_name, "\\/", "v");
    _name = string_replace_all(_name, "9", "g");
    _name = string_replace_all(_name, "8", "b");
    _name = string_replace_all(_name, "7", "t");
    _name = string_replace_all(_name, "5", "s");
    _name = string_replace_all(_name, "2", "s");
    _name = string_replace_all(_name, "$", "s");
    _name = string_replace_all(_name, "()", "0");
    _name = string_replace_all(_name, "_", "");
    _name = string_replace_all(_name, " ", "");
    _name = string_replace_all(_name, "-", "");
    _name = string_replace_all(_name, "|", "");
    _name = string_replace_all(_name, "/", "");
    _name = string_replace_all(_name, ".", "");
    _name = string_replace_all(_name, ",", "");
    _name = string_replace_all(_name, "<", "");
    _name = string_replace_all(_name, ">", "");
    _name = string_replace_all(_name, "?", "");
    _name = string_replace_all(_name, "[", "");
    _name = string_replace_all(_name, "]", "");
    _name = string_replace_all(_name, ";", "");
    _name = string_replace_all(_name, ":", "");
    _name = string_replace_all(_name, "'", "");
    _name = string_replace_all(_name, "'", "");
    _name = string_replace_all(_name, "+", "");
    _name = string_replace_all(_name, "=", "");
    _name = string_replace_all(_name, "=", "");
    _name = string_replace_all(_name, "#", "");
    _name = string_replace_all(_name, "%", "");
    _name = string_replace_all(_name, "^", "");
    _name = string_replace_all(_name, "*", "");
    _name = string_replace_all(_name, "(", "");
    _name = string_replace_all(_name, ")", "");
    _name = string_replace_all(_name, "`", "");
    _name = string_replace_all(_name, "~", "");
    _name = string_replace_all(_name, "\"", "");

    _name = _namefilter_collapse_repeated_letters(_name);

    return _name; 
}

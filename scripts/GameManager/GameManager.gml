randomize();

window_set_caption("Crackle");

global.game_state = GameState.GAMEPLAY;
global.player_name = "";

function gamemanager_gameplay_state(){
    global.game_state = GameState.GAMEPLAY;
    layer_set_visible(LAYER_MENU_TEXT,          false);
    layer_set_visible(LAYER_MENU_BUTTONS,       false);
    layer_set_visible(LAYER_MENU_BACKGROUND,    false);
}

function gamemanager_menu_state(){
    global.game_state = GameState.MENU;
    layer_set_visible(LAYER_MENU_TEXT,          true);
    layer_set_visible(LAYER_MENU_BUTTONS,       true);
    layer_set_visible(LAYER_MENU_BACKGROUND,    true);
    audiomanager_play_game_over();
}

enum GameState{
    MENU,
    GAMEPLAY,
}
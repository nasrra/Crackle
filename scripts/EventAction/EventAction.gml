function EventAction(_function) constructor{
    action = _function;
    // calls the function.
    function invoke(){
        if(action != undefined){
            action();
		}
    }
    // sets what function to call.
    function set(_function){
        action = _function;
    }
}
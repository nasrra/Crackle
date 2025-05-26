root = "leaderboard";

on_press_ext = function(){
	// query the data base when going to the leaderboards.
	FirebaseFirestore(root).Query();
}
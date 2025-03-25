/// @description Lock the player in place. The player can't move and hsp, vsp becomes 0.
function player_lock(){
	with (oOui) {
        hascontrol = false;
        hsp = 0;
        vsp = 0;
    }
}
/// @description Jump boost on collision with player
// You can write your code in this editor

with(oOui){
	jumpspd = jumpspd_boost
	currentS = sOuiJump;
	sprite_index = currentS;
	alarm[0] = 300;
	}

instance_destroy();
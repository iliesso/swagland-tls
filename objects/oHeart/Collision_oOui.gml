/// @description Player collects heart

with (oOui) {

	//if player's health isn't maxed
	if (life < sprite_get_number(sHeart)){
		life += 1;	
	}
	
	//if player has max health
	else {
		//do something else idk yet
	}

}

//update displayed hearts
with (oPlayerHearts) {
	life = oOui.life;	
}

instance_destroy();
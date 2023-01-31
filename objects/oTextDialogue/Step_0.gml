/// @description break text when finished

animProgress += (1 - animProgress) / 50;
textProgress += global.textSpeed;

x1 = lerp(x1, x1Target, animProgress);
x2 = lerp(x2, x2Target, animProgress);

if (keyboard_check_pressed(global.keyAction) || mouse_check_button(mb_right)){    //if action or right click pressed
	if (textProgress >= length){	//if text animation finished, destroy dialogue.
		instance_destroy();	
	}
	else if (textProgress > 2){		//if user wants to skip text animation
		textProgress = length;
	}
}

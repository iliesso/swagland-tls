/// @description break text when finished

//Sprite apparition
if (instance_exists(oCamera)){  //if there is a camera
	if (!instance_exists(spr)){
		spr = instance_create_layer(oCamera.x*1.8, oCamera.y*1.095,"HUD", asset_get_index(speaker));
		with (spr){
			image_xscale = 7;
			image_yscale = 7;
			image_speed = 0;
			image_angle += 23
		}
	}
	else {
		spr.x += (oCamera.x*sprite_x_target - spr.x) / speakerEntrance;
	}
}

else{   //if there is no camera (small house for example)
	if (!instance_exists(spr)){
		spr = instance_create_layer(RESOL_W*1.3, RESOL_H *0.73,"HUD", asset_get_index(speaker));
		with (spr){
			image_xscale = 7;
			image_yscale = 7;
			image_speed = 0;
			image_angle += 23
		}
	}
	else {
		spr.x += (sprite_x_target_nocam - spr.x) / speakerEntrance;
	}
}


//Text box creation and text progression
animProgress += (1 - animProgress) / 50;
textProgress += global.textSpeed;

x1 = lerp(x1, x1Target, animProgress);
x2 = lerp(x2, x2Target, animProgress);

if (keyboard_check_pressed(global.keyAction) || mouse_check_button_pressed(mb_right)){    //if action or right click pressed
	if (textProgress >= length){	//if text animation finished, destroy dialogue.
		if (page+1 < array_length(msg)){
			page++;
		}
		else{
			with(oOui){ hascontrol = true;}
			with(oCamera){ follow = oOui;}
			instance_destroy(spr);
			instance_destroy();
		}
	}
	else if (textProgress > 2){		//if user wants to skip text animation
		textProgress = length;
	}
}

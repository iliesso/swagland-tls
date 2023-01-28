/// @description If choice is clicked

//no
if (point_in_rectangle(mouse_x, mouse_y, x-125, y+30, (x-102) + 24, (y+65) + 5)){
	//light text
	if (hoveryes){
		hoveryes = false;
		hoverno = true;
	}
	//click action
	if (mouse_check_button_released(mb_left)){
		game_restart();
	}
}

//keyboard selection
if (keyboard_check_pressed(vk_left) ||keyboard_check_pressed(ord("Q")) ){
	if (!hoverno && !hoveryes){
		hoverno = true;	
	}
	if (hoveryes){
		hoveryes = false;
		hoverno = true;
	}	
}
if (keyboard_check_pressed(vk_right) ||keyboard_check_pressed(ord("D")) ){
	if (!hoverno && !hoveryes){
		hoverno = true;
	}
	if (hoverno){
		hoverno = false;
		hoveryes = true;
	}	
}
if (keyboard_check_pressed(vk_enter) ||keyboard_check_pressed(ord("E")) ){
	if (hoveryes){
		if (page < 1){
			page +=1;	
		} else {
			SlideTransition(TRANS_MODE.GOTO,rNiv1); //TRANSITION AU NIVEAU 1
			if (!object_get_visible(oMenu)){
					object_set_visible(oMenu, true);
				}
			instance_destroy();	
		}
	}
	if (hoverno){
		game_restart();
	}	
}

//yes
if (point_in_rectangle(mouse_x, mouse_y, x+70, y+30, (x+115), (y+65) + 5)){
	//light text
	if (hoverno){
		hoverno = false;
		hoveryes = true;	
	}
	
	//click action
	if (mouse_check_button_released(mb_left)){
		if (page < 1){
			page +=1;
		} else {
			SlideTransition(TRANS_MODE.GOTO,rDev1);
			if (!object_get_visible(oMenu)){
					object_set_visible(oMenu, true);
				}
			instance_destroy();	
		}
		
	}
}
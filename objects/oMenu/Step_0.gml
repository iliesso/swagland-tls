/// @description Control menu 


//Slide text animation
menu_y += (menu_y_target - menu_y) / menu_speed;

//Keyboard controls
if (menu_control) {
	if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("Z")) ){
		menu_cursor++;
		if (menu_cursor >= menu_items){
			menu_cursor = 0;	//moves cursor to option above, or back all the way down if already at the top
		}
	}
	if (keyboard_check_pressed(vk_down) ||keyboard_check_pressed(ord("S")) ){
		menu_cursor--;
		if (menu_cursor < 0){
			menu_cursor = menu_items-1;	//moves cursor to option below, or back all the way up if already at the bottom
		}
	}
	
	if (keyboard_check_pressed(vk_enter)){
		menu_y_target = gui_height + 450;   //slide menu outside the screen
		menu_committed = menu_cursor;
		ScreenShake(3,30);
		menu_control = false;
	}
	
	//Mouse controls
	if (point_in_rectangle(mouse_x, mouse_y, 435, 355, 565, 380)){
		menu_cursor = 3;
		if (mouse_check_button_released(mb_left)){
			menu_y_target = gui_height + 450;   //slide menu outside the screen
			menu_committed = menu_cursor;
			ScreenShake(3,30);
			menu_control = false;
		}
	}
	if (point_in_rectangle(mouse_x, mouse_y, 435, 381, 565, 410)){
		menu_cursor = 2;
		if (mouse_check_button_released(mb_left)){
			menu_y_target = gui_height + 450;   //slide menu outside the screen
			menu_committed = menu_cursor;
			ScreenShake(3,30);
			menu_control = false;
		}
	}
	if (point_in_rectangle(mouse_x, mouse_y, 435, 411, 565, 440)){
		menu_cursor = 1;
		if (mouse_check_button_released(mb_left)){
			menu_y_target = gui_height + 450;   //slide menu outside the screen
			menu_committed = menu_cursor;
			ScreenShake(3,30);
			menu_control = false;
		}
	}
	if (point_in_rectangle(mouse_x, mouse_y, 435, 441, 565, 465)){
		menu_cursor = 0;
		if (mouse_check_button_released(mb_left)){
			menu_y_target = gui_height + 450;   //slide menu outside the screen
			menu_committed = menu_cursor;
			ScreenShake(3,30);
			menu_control = false;
		}
	}
}




if (menu_y > gui_height+200) && (menu_committed != -1){
	switch (menu_committed){
		case 3:  //3 = New Game
			if (file_exists(SAVEFILE)){
				if (warnbox == noone){
				warnbox = instance_create_layer(gui_width/2,gui_height/2,"warningmsg",oTextboxGun,{ texte: warningMsg });
				break;
				}
				break;
			} else {
				SlideTransition(TRANS_MODE.GOTO,rDev1); 
				break;
			}
			break;
		case 2:   //2 = Continue
			if (!file_exists(SAVEFILE)){
				SlideTransition(TRANS_MODE.NEXT);	
			}
			else {
			var file = file_text_open_read(SAVEFILE);
			var target = file_text_read_real(file);
			file_text_close(file);
			SlideTransition(TRANS_MODE.GOTO,target);
			}
			break;
		case 1:   //1 = Options
			SlideTransition(TRANS_MODE.GOTO,rOptions);
			break;
		case 0:   //0 = Quit
			game_end();
			break;
		
	}
}

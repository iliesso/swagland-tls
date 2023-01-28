/// @description Control option menu 


//Slide text animation
menu_x += (menu_x_target - menu_x) / menu_speed;

//Keyboard controls
if (menu_control) {
	if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("Z")) ){
		menu_cursor++;
		if (menu_cursor >= menu_items){
			menu_cursor = 0;	//moves cursor to option above, or back all the way down if already at the top
		}
	}
	if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")) ){
		menu_cursor--;
		if (menu_cursor < 0){
			menu_cursor = menu_items-1;	//moves cursor to option below, or back all the way up if already at the bottom
		}
	}
	
	if (keyboard_check_pressed(vk_enter)){
		
		//If anything other than language is chosen (language = 1)
		if (menu_cursor != 1){
			menu_x_target = gui_width + 400;   //slide menu outside the screen
			menu_committed = menu_cursor;
			ScreenShake(3,30);
			menu_control = false;
		}
		
		//If language is chosen
		else {
			menu[1] = "Language (coming soon !)";
			//switch language
		}
	}
}

//If menu animation ended, player can use it
if (menu_x > gui_width+200) && (menu_committed != -1){
	
	//Different menu options
	switch (menu_committed){
		
		case 4:  //4 = Sound options
			room_goto(rOptionsSound);
			break;
		
		case 3:  //3 = Video options
			room_goto(rOptionsVideo);
			break;
			
		case 2:   //2 = Controls
			room_goto(rOptionsControls);
			break;
			
		case 1:   //1 = Language
			//insert here language switch
			
			break;
			
		case 0:   //0 = Back to main menu
			SlideTransition(TRANS_MODE.GOTO,rMenu);
			break;
		
	}
}

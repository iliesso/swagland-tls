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
		menu_x_target = gui_width + 400;   //slide menu outside the screen
		menu_committed = menu_cursor;
		ScreenShake(3,30);
		menu_control = false;
	}
}

//If menu animation ended, player can use it
if (menu_x > gui_width+200) && (menu_committed != -1){
	
	//Different menu options
	switch (menu_committed){
			
		case 1:   //1 = work in progress
			//change controls
			room_goto(rOptions);
			break;
			
		case 0:   //0 = Back to options
			room_goto(rOptions);
			break;
		
	}
}

/// @description GUI/variables/setup


gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
gui_margin = 32;

menu_x = gui_width + 400;  //Starts outside the limits to slide into the screen (launch animation in step event)
menu_y = gui_height / 2;
menu_x_target = gui_width / 2;
menu_speed = 20;	//higher = faster
menu_font = fMenu;
menu_itemheight = font_get_size(fMenu)+3;		//space between options
menu_committed = -1;    //default = -1; else: selected menu option.
menu_control = true;    //true: player can use the menu

menu[1] = "Coming soon !";
menu[0] = "Go back";

menu_items = array_length_1d(menu);		//menu length
menu_cursor = menu_items -1 ;	//default item chosen(first)

//Background following cursor speed
menu_background_speed = 100;	//The higher = the faster. Default = 100. Negative = slower.
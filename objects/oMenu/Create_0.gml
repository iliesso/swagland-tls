/// @description GUI/variables/setup

#macro SAVEFILE "Save.sav"

gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
gui_margin = 32;

menu_y = gui_height + 400;  //Starts outside the limits to slide into the screen (launch animation in step event)
menu_y_target = gui_height / 2 + 100;
menu_x = gui_width / 2;
menu_speed = 20;	//higher = faster
menu_font = fMenu;
menu_itemheight = font_get_size(fMenu)+3;		//space between options
menu_committed = -1;    //default = -1; else: selected menu option.
menu_control = true;    //true: player can use the menu

menu[3] = "New Game";
menu[2] = "Continue";
menu[1] = "Options";
menu[0] = "Quit";

menu_items = array_length_1d(menu);		//menu length
menu_cursor = menu_items-1;

//Background following cursor speed
menu_background_speed = 100;	//The higher = the faster. Default = 100. Negative = slower.

//Start new game: Save erase?
erase_save = false; //changer to false!
warningMsg[0] = "  Une sauvegarde existe deja, voulez vous vraiment recommencer le jeu? Cela effacera la sauvegarde actuelle. ";
warningMsg[1] = "  Pas de regret, hein?";
warnbox = noone;
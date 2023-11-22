/// @description Display option menu


draw_set_font(menu_font);
draw_set_halign(fa_center);
//draw_set_valign(fa_bottom);

for (var i = 0; i < menu_items; i++){
	var offset = 1;		//set up text contour
	var txt = menu[i];		//display all the different options
	var col = c_white;
	if (menu_cursor == i){
		txt = string_insert(">> ",txt ,0);	
		col = c_white;	
	}
	else {             //if not selected: draw text in gray
		col = c_gray;
	}
	
	var xx = menu_x;
	var yy = menu_y - (menu_itemheight * (i * 1.5));  //y menu text position
	
	//draw_set_halign(fa_center);   //center text
	draw_set_color(c_black);    //contour text
	draw_text(xx+offset,yy,txt);
	draw_text(xx-offset,yy,txt);
	draw_text(xx,yy+offset,txt);
	draw_text(xx,yy-offset,txt);
	
	
	draw_set_color(col);  //draw menu 
	draw_text(xx,yy,txt);
}
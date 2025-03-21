if (show == true) 
{

	draw_set_color(c_dkgrey);
	draw_text(16,44,"fps: " + string(fps));
	draw_set_halign(fa_left);
	draw_text(16,64,"R: redemarrer le jeu");
	draw_set_halign(fa_left);
	draw_text(16,84,"P: cacher/afficher le debuggeur");
	draw_set_halign(fa_left);
	if (instance_exists(oOui)){
		draw_text(16,104,"Player object: oOui |  oOui hsp= " + string(oOui.hsp) + ", oOui vsp= "  + string(oOui.vsp));	
		draw_set_halign(fa_left);
	} else if (instance_exists(oMenu)){
		draw_text(16,104,"xSpeed Background: " + string(oMenu.xSpd));
		draw_set_halign(fa_left);
	}
	draw_text(16,124,"mouse_x_y: " + string(mouse_x) + " ; " + string(mouse_y));
	draw_set_halign(fa_left);
	
}
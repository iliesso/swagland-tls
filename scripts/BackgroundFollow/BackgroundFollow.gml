/// @description Background control
//Plus on se dirige vers les extrémités de l'écran, plus le background défile vite.

function BackgroundFollow(layerName){


//Definition de x: varie en fonction de la position du curseur.
	if(mouse_x < gui_width/2){  //Milieu horizontal de l'écran = 500px.
		x = (-gui_width/2) - (-mouse_x);  //x va de -500 à 0.
	}else{
		x = mouse_x - gui_width/2;  //x va de 0 à 500.
	}
	
	/*return x;
}*/

//
//Le background suit le curseur (mouvement horizontal):
//x = mousepos();
xSpd = x/(gui_width/2 - menu_background_speed);    //La vitesse de défilement du background en fonction de la position du curseur.



layer_hspeed(argument0, xSpd);



//Le background suit le curseur (mouvement vertical):
	if(mouse_y < gui_height/2){  //Milieu vertical de l'écran = 375px.
		y = (-gui_height/2) - (-mouse_y);  //y va de -375 à 0.
	}else{
		y = mouse_y - gui_height/2;  //y va de 0 à 375.
	}
	
ySpd = y/(gui_height/2 - (menu_background_speed*0.75));    // menu_background_speed multiplié par 0.75 car hauteur de l'écran de jeu 0.75x largeur de l'écran de jeu..



layer_vspeed(argument0, ySpd);
}
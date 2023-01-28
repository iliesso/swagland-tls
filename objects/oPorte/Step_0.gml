/// @description Emmène le joueur vers la salle

if (instance_exists(oOui)){
	if (point_in_circle(oOui.x, oOui.y, x, y, 48)){
	
		if (!instance_exists(oText) && !instance_exists(oIndic)){
		    indic = instance_create_layer(x, y-16, "Indic", oIndic);	
		}
		
		//on interact key press
		if (instance_exists(indic) && keyboard_check_pressed(ord("E")) || mouse_check_button_released(mb_right)){
			instance_destroy(indic);
			with (oOui) 
			{
				if (hascontrol)
				{
					hascontrol = false;
					
					//Sets player spawn point in next room
					global.targetX = other.targetX;
					global.targetY = other.targetY;
					global.target = other.target;
					
					//Sets global cam zoom
					global.camWidth = other.camWidth;
					SlideTransition(TRANS_MODE.GOTO, global.target);
					instance_destroy();
				}
			}
		}
		
	}
	else {
		if (instance_exists(indic)){
			instance_destroy(indic);
		}
	}
}
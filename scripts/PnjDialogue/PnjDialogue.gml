///@description puts indic marker on top of object

function PnjDialogue(){
if (instance_exists(oOui)){
	if (point_in_circle(oOui.x, oOui.y, x, y, 48)){ //64 = indication radius
	
		if (!instance_exists(oText) && !instance_exists(oIndic)){
		    indic = instance_create_layer(x, y-16, layer, oIndic);	
		}
		
		//on interact key press
		if (keyboard_check_pressed(ord("E")) || mouse_check_button_released(mb_right)){
			instance_destroy(indic);
			
			//***
			//FAIRE LE DIALOGUE ICI
			//***
			
			
			
	
			/* Camera focus on sign
			with (oCamera){
				follow = other.id;
			}
			*/
		}
	} 
	else {
		if (instance_exists(indic)){
			instance_destroy(indic);	
		}
	}
}
}
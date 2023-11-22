/**@description puts indic marker on top of object, 
* then on keyboard press, destroy indic, 
* show dialogue
* 
*/

function PnjDialogue(){
if (instance_exists(oOui)){
	if (point_in_circle(oOui.x, oOui.y, x, y, 48)){ //48 = indication radius
		if (!instance_exists(oTextDialogue)){		    //if text doesn't already exist
			if (!instance_exists(oIndic)){
			    indic = instance_create_layer(x, y-16, layer, oIndic);	
			}
			
			//on interact key press
			if (keyboard_check_pressed(global.keyAction) || mouse_check_button_pressed(mb_right)){
				instance_destroy(indic);
			
				//***
				//FAIRE LE DIALOGUE ICI
				//***
				with(oOui){ 
					hascontrol = false;
					hsp = 0;
					vsp = 0;
					}
				with (instance_create_layer(x, y-16, layer, oTextDialogue)){
					//other = this speaker
					speaker = object_get_name(other.object_index);
					msg = other.text;
					length = string_length(msg);
					}
				
				// Camera focus on pnj
				with (oCamera){
					follow = other.id;
				}
		}
	}
	}
	else{
		if (instance_exists(indic)){
			instance_destroy(indic);	
		}
	}
}
}
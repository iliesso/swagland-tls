/// @description Display sign text when player interacts

//if player in radius

access = keyboard_check_pressed(ord("E"));

if (instance_exists(oOui)){
	if (point_in_circle(oOui.x, oOui.y, x, y, radius)){
	if (!instance_exists(oText)){
		if (!instance_exists(indic)){
		    indic = instance_create_layer(x, y-16, layer, oIndic);	
		}
		
		//on interact key press
		if (access){
			instance_destroy(indic);
			with (instance_create_layer(x, y-16, layer, oText)){
		
				//other = this sign
				text = other.text;	
				length = string_length(text);
			}	
	
			// Camera focus on sign
			with (oCamera){
				follow = other.id;
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
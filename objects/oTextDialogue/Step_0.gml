/// @description progress text

//destroy text when finished reading
if ( (letters >= length) && (keyboard_check_pressed(vk_anykey))){
	
	instance_destroy();
	with(oCamera){ follow = oOui; }
	
}
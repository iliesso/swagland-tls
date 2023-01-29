//key binds, controller and gamepad management

if (hascontrol = true)
{
	
	key_right = keyboard_check(vk_right) || keyboard_check(global.keyRight); //keyboard_check(ord("D")) default
	key_left = keyboard_check(vk_left) || keyboard_check(global.keyLeft); //keyboard_check(ord("Q")) default
	key_up = keyboard_check(global.keyJump);
	key_sprint = keyboard_check(global.keySprint);

	if (key_left) || (key_right) || (key_up) 
	{
		controller = 0;	
	}

	if (abs(gamepad_axis_value(0,gp_axislh)) > 0.2)
	{
		key_left = abs(min(gamepad_axis_value(0,gp_axislh),0));
		key_right = max(gamepad_axis_value(0,gp_axislh),0);
		controller = 1;
	}

	if (gamepad_button_check_pressed(0,gp_face1))
	{
		key_up = 1;
		controller = 1;
	}


	//input and movement link
	directio= key_right - key_left;
	if (vsp < -3 || vsp > 3){        //if going up or down in the air (faster than 3)
		hsp = directio * (walkspd);  //can't sprint in the air
	} else {
		hsp = directio * (walkspd + (key_sprint*key_sprint)); //Walks towards left or right depending if "directio" == 1 or -1. If player sprinting, add sprint speed.
	}

	//Jump ledge grace time
	if (!on_ground){
		if (canjump > 0){
			
			canjump -= 1;
			
			if (jumped == false){
				
				if (key_up){
					
					vsp = -jumpspd;   //Jump
					jumped = true;
					
				}
			}
		}
	} else{
		jumped = false;
		canjump = buffer_max;
	}
	
	//Jump buffer grace time
	if (key_up){ buffer_counter = buffer_max; }
	
	if (buffer_counter > 0){
		
		buffer_counter -= 1;
		
		if (on_ground){
			
			vsp = -jumpspd;
			buffer_counter = 0;
			jumped = true;
			
		}
	}
	
	if (vsp < 0 && (!key_up)){
		vsp += grv;	   //if player stops pressing "jump", stop going higher.
	}
	
	
	/* 
	canjump -= 1; 
	if (canjump > 0 && (key_up != 0)) //If player standing on the ground & jumping
	{ 
		
		buffer_counter = buffer_max; //set jump buffer when jumping
		canjump = 0;   //Can not jump anymore, has to touch ground again.
		
	}
	
	if (vsp < 0 && (!key_up)){
		vsp += grv;	   //if player stops pressing "jump", stop going higher.
	}*/
}

//if hascontrol == false
else  
{
	key_right = 0;
	key_left = 0;
	key_up = 0;
}



if (vsp < fallspeed) {
	vsp += grv;	
}

#region //collision

//If player in the air or on ground checking
if (place_meeting(x,y+1,oWall)){
	on_ground = true;
} else {
	on_ground = false;
}


//horizontal collision

if place_meeting(x+hsp, y, oWall)
{
	while (!place_meeting(x+sign(hsp), y, oWall))
	{
			x += sign(hsp);
	}
	hsp = 0;
}
x+= hsp;

//vertical collision

if (place_meeting(x, y+vsp, oWall))
{
	while (!place_meeting(x, y+sign(vsp), oWall))  //If player close to touching the ground, pull him exactly on the ground.
	{
			y += sign(vsp);
	}
	vsp = 0;
}
y+= vsp;

#endregion


#region //sprite animation

if (!on_ground)    //if in the air
{
	sprite_index = 	sOuiFall;
	image_speed = 0;      //not animating: only use wanted frame
	
	if (sign(vsp)>0) {   //if falling use fall frame, if going up us going up frame
		image_index = 0;	
	} else {
		image_index = 1;
	}
	
} 
else
{	
	image_speed = 1;
	if (hsp == 0)             //if standing
	{
		sprite_index = currentS;
	}
	else                      //if running
	{
		sprite_index = sOuiRun;
	}
}

if (hsp != 0) image_xscale = sign(hsp);   //flip sprite horizontally according to facing side

#endregion
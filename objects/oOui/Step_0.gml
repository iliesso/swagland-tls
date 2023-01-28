//key binds, controller and gamepad management

if (hascontrol = true)
{
	
key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
key_left = keyboard_check(vk_left) || keyboard_check(ord("Q"));
key_up = keyboard_check(vk_space);

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
hsp = directio * walkspd;


if place_meeting(x,y+1,oWall) //If player standing on the ground
{
	vsp = key_up * -jumpspd;
}

} else
{
	key_right = 0;
	key_left = 0;
	key_up = 0;
}

if (vsp < 10) {
	vsp += grv;	
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

if place_meeting(x, y+vsp, oWall)
{
	while (!place_meeting(x, y+sign(vsp), oWall))
	{
			y += sign(vsp);
	}
	vsp = 0;
}
y+= vsp;

//sprite animation
if (!place_meeting(x,y+1,oWall))    //if in the air
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
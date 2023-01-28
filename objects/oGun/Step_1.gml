/// @description gun movement

x = oOui.x+9;
y = oOui.y-14;

if(mouse_x > x) image_yscale = 1; else image_yscale = -1;   //if cursor x before gun x, flip gun towards cursor

if (oOui.controller == 0)  //if controller not used
{
		image_angle = point_direction(x,y,mouse_x,mouse_y);   //follow cursor
} else
{
	var controllerh	= gamepad_axis_value(0,gp_axisrh);
	var controllerv	= gamepad_axis_value(0,gp_axisrv);
	if (abs(controllerh) > 0.2) || (abs(controllerv) > 0.2)   //deadzone (if stick is pulled enough)
	{
			controllerangle = point_direction(0,0,controllerh, controllerv);  //Angle is where joystick points
	}
	image_angle = controllerangle;
}

if (recoil > 0)	recoil -= 1; else recoil = 0;      //each frame, recoil -1.
firingdelay -= 1;        //each frame, firingdelay -1.

if (mouse_check_button(mb_left)) && (firingdelay < 0)
{
	recoil = 2;
	firingdelay = 6;         //firing delay back to 6 frames.
	ScreenShake(gun_screenshake_magn,10);
	with (instance_create_layer(x,y,"Shoot",oShoot))
	{	
		speed = 20;
		direction = other.image_angle + random_range(-1,1);   //direction becomes image_angle of oGun.
		image_angle = direction;
		
	}
}

x -= lengthdir_x(recoil,image_angle);
y -= lengthdir_y(recoil,image_angle);
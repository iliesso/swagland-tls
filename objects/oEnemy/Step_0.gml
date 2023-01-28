
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
	hsp = -hsp;
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
	sprite_index = 	sEnemyFall;
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
		sprite_index = sEnemy;
	}
	else                      //if running
	{
		sprite_index = sEnemyRun;
	}
}

if (hsp != 0) image_xscale = sign(hsp);   //flip sprite horizontally according to facing side
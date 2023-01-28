if (fallen == 0)   //if dead player still hasn't fallen
{
	
if (vsp < 10) 
{
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
	if (vsp > 0)   //check if the dead enemy was falling
	{
		fallen = 1;       //fallen state to 1 (true).
		image_index = 1;
		alarm[0] = 36;	  //wait 36 frames after falling to activate death
	}
	while (!place_meeting(x, y+sign(vsp), oWall))
	{
			y += sign(vsp);
	}
	vsp = 0;
}
y+= vsp;

}

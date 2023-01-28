if (fallen == 0)   //if dead enemy didn't fall
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
	if (vsp > 0)   //if the dead enemy is falling
	{
		fallen = 1;       //fallen state to 1 (true).
		image_index = 1;
	}
	while (!place_meeting(x, y+sign(vsp), oWall))
	{
			y += sign(vsp);
	}
	vsp = 0;
}
y+= vsp;

}

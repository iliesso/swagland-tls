/// @description vase falls and breaks

/// @description When player touches it, it falls and breaks

if (broken){
	
	if (hit = 0){
		hit = 1;
		if place_free(x-sprite_width,y)
	    {
			x+=2*hitfrom;
	    }
	}
	
	if (fallen == 0)   //if vase still hasn't fallen
	{
	
	hsp = random_range(0.5,1)*hitfrom;
	if (sign(hsp) != 0) image_xscale = sign(hsp);
	
	if (vsp < 3) 
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
		}
		while (!place_meeting(x, y+sign(vsp), oWall))
		{
				y += sign(vsp);
		}
		vsp = 0;
	}
	y+= vsp;

	} else {  //If vase has fallen
	hsp = 0;
	}
}
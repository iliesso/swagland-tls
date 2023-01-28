hsp = 0;
vsp = 0;
grv = 0.3;
fallen = 0;

image_speed = 0;
image_index = 0;

ScreenShake(3,50);

with(oCamera){			//make camera follow oPlayerDead instead of oPlayer 
	follow = other.id;
}


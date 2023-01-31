// @description update camera

//Update destination	


if (instance_exists(follow))
{
	xTo = follow.x;
	yTo = follow.y;
	
	//if player dies, don't move camera
	if (follow.object_index == oPlayerDead) {
		x = xTo;
		y = yTo;
	}
}

//Update object position and follow
x += (xTo - x) / cam_smoothness;
y += (yTo - y) / cam_smoothness;

x = clamp(x, view_w_half + buff, room_width-view_w_half - buff);     //Camera limits to room borders
y = clamp(y, view_h_half + buff, room_height-view_h_half - buff);    //buff spares inside room space for the shake

//screen shake
x += random_range(-shake_remain, shake_remain);
y += random_range(-shake_remain, shake_remain);
shake_remain = max(0, shake_remain-((1/shake_length)*shake_magnitude));   //substracts 1/60th of magnitude each frame, until remain reaches 0

//Assign cam view
camera_set_view_pos(cam, x-view_w_half, y-view_h_half);


//Parallax effect

if (layer_exists("BackgroundMountains"))
{
	layer_x("BackgroundMountains", x/parlx1);	
}

if (layer_exists("BackgroundTrees"))
{
	layer_x("BackgroundTrees", x/parlx2);	
}

/// @description camera variables

cam = view_camera[0];

follow = oOui;
view_w_half = camera_get_view_width(cam)/2;
view_h_half = camera_get_view_height(cam)/2;

xTo = xstart;
yTo = ystart;

cam_smoothness = 4;   //the higher, the smoother the camera follows object

shake_length = 0;   //60 frames, so 1 second of screen shaking
shake_magnitude = 0;   //the higher, the more the screen shakes
shake_remain = shake_magnitude;   //what remains to shake before stopping
buff = 32;   //buffer, to avoid cam from escaping borders


//Parallax
//higher: faster background movement

parlx1 = 1.5    //mountains
parlx2 = 2      //trees

//Camera zooming
camwidthMenu = 1000;
camheightMenu = 750;
camwidthGame = 288;
camheightGame = 216;
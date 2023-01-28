/// @description adapt camera zoom to room

 //Main menu
if (layer_exists("BackgroundMenu")){
	buff = 0;
	camera_set_view_size(cam, camwidthMenu, camheightMenu);	
} else {
	buff = 32;
	camera_set_view_size(cam, global.camWidth, (global.camWidth*0.75));
}
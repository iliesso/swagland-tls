/// @description Fullscreen control

//If fullscreen toggled in options, or if F11 pressed
if (keyboard_check_pressed(vk_f11)){
	window_set_fullscreen(!window_get_fullscreen());   //toggle fullscreen
	global.fullscreen = !global.fullscreen;
}
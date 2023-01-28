/// @description Transports player to target room

if (instance_exists(oOui) && position_meeting(oOui.x, oOui.y, id)){
	global.target = target;
	global.targetX = targetX;
	global.targetY = targetY;
	SlideTransition(TRANS_MODE.GOTO, target);
	instance_destroy();
}
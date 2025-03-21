/// @description Transports player to target_room

if (instance_exists(oOui) && position_meeting(oOui.x, oOui.y, id)){
	global.target_room = target_room;
	global.targetX = targetX;
	global.targetY = targetY;
	SlideTransition(TRANS_MODE.GOTO, target_room);
	instance_destroy();
}
//move
hsp = 0;
vsp = 0;
grv = 0.12;		 //default 0.12
fallspeed = 5;   //default 5
walkspd = 2.3;   //default 2.3
sprintspd = 1;	 //default 1
hascontrol = true;


//jump state
jumpspd_normal = 3.5;
jumpspd_boost = 5.8;
jumpspd = jumpspd_normal;
canjump = 0;

//player state
damageCountdown = false;	   //after every damage taken, little cooldown (few seconds)
damageCountdownDuration = 130;  //frame countdown
flash = 0;					   //flashing white when hit
flashCounter = 0;

//player effects (health, buffs...)
life = 1;

//sprite
currentS = sOui;

//controls
controller = 0;		//0 = controller not used, 1 = controller used

//navigation
if (global.targetX != -1){
	x = global.targetX;
	y = global.targetY;
}


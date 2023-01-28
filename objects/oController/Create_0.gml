/// @description Persistant controller: stores every variable
/// that need to go to the next room

//**********
//**GLOBAL**
//**********

//Game variables
global.gamePaused = false;
global.textSpeed = 0.75;

//Player variables
global.target = -1;
global.targetX = -1;
global.targetY = -1;

//Camera variables
//No need to define camHeight as it will always be camWidth*0.75.
global.camWidth = 288;



//********
//**KEYS**
//********
keyAction[0] = vk_enter;
keyAction[1] = ord("E");

keyJump[0] = vk_space;

keyLeft[0] = ord("Q");
keyLeft[1] = vk_left;

keyRight[0] = ord("D");
keyRight[1] = vk_right;

keyUp[0] = ord("Z");
keyUp[1] = vk_up;

keyDown[0] = ord("S");
keyDown[1] = vk_down;

keyBag[0] = ord("F");

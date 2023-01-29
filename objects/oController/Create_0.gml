/// @description Persistant controller: stores every variable
/// that need to go to the next room

//**********
//**GLOBAL**
//**********

#region //Game variables
global.gamePaused = false;
global.textSpeed = 0.75;
global.fullscreen = false;

#endregion


#region //Player variables
global.target = -1;
global.targetX = -1;
global.targetY = -1;

#endregion


#region //Camera variables
//No need to define camHeight as it will always be camWidth*0.75.
global.camWidth = 288;

#endregion


//********
//**KEYS**
//********

#region //Controls
global.keyRight = ord("D");
global.keyLeft = ord("Q");
global.keyJump = vk_space;
global.keySprint = vk_shift;
global.keyAction = ord("E");

#endregion
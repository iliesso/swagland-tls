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
global.camWidth = RESOL_W;

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


//*******************
//**STORY VARIABLES**
//*******************


#region //Arc 1


	#region //Niv 1
	global.story_niv1_vase = false;   //Objets de sylvie tous cassés ou pas dans sa maison.
	global.story_niv1_sprint = false;  //joueur débloque le sprint
	global.story_niv1_philippe_rencontre = false;  //première rencontre avec philippe
	global.story_niv1_philippe_rencontre2 = false;  //après avoir parlé à philippe une deuxième fois
	global.story_niv1_philippe_rencontre3 = false;
	#endregion


#endregion


//***************
//**GAME VALUES**
//***************

#region //Persistant game values
global.playerName = "Warda";

#endregion


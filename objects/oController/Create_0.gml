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
global.target_room = -1;
global.targetX = 79;
global.targetY = 250;
global.interactionRadius = 48;
global.interaction_radius_recoil_zone = 10;

#endregion


#region //Camera variables
//No need to define camHeight as it will always be camWidth*0.75.
global.camWidth = RESOL_W;

#endregion

#region //PNJ Manager

pnj_states = ds_map_create();

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


#region //Acte 1: Début

	
	#region //Arc Début


		#region //Niv1
		global.story_niv1_vase = false;   //Objets de sylvie tous cassés ou pas dans sa maison.
		#endregion
	
	#endregion


#endregion


//***************
//**GAME VALUES**
//***************

#region //Persistant game values
global.playerName = "Warda";

#endregion


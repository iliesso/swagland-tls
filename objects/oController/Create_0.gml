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

// Utilise un struct au lieu de ds_map (moderne GML)
pnj_states = {};

#endregion

// Enregistrer les événements d'histoire
register_story_events();


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
// NOTE: Maintenant géré par global.story (StoryManager)
// Utiliser: story_flag("niv1.vase_broken", value)
// ou: story_check("niv1.vase_broken")

#region //Acte 1: Début

	#region //Arc Début

		#region //Niv1
		// DEPRECATED: Les flags sont maintenant dans global.story.flags
		// global.story_niv1_vase remplacé par story_flag("niv1.vase_broken")
		#endregion
	
	#endregion

#endregion


//***************
//**GAME VALUES**
//***************

#region //Persistant game values
global.playerName = "Warda";

#endregion


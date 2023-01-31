/// @description sylvie stuff

switch (room){
	case rMaisonspawn:
	{
		if (!global.story_niv1_vase){
			text[0] = "...";
		} else{
			text[0] = "Et qui c'est qui va nettoyer apres...";	
		}
		break;	
	}
}


if (text[0] != -1){
	PnjDialogue();
}
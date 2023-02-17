/// @description philippe stuff
switch (room){
	case rNiv1:
	{
		if (!global.story_niv1_philippe_rencontre){
			text[0] = "Bonjour mon grand. Moi c'est Philippe, et toi?.";
			text[1] = "Alors comme ça tu t'appelles " + string(global.playerName) + "...";
			text[2] = "Fais attention aux falaises c'est dangereux ici.";
			
		} else if (!global.story_niv1_philippe_rencontre2){
			text[0] = "J'ai d'autres choses à faire maintenant.";
			
		}  else if (!global.story_niv1_philippe_rencontre3){
			text[0] = "...";
			
		} else {
			text[0] = "Allez va gambader ailleurs mon grand.";
		}
		
		break;	
	}
	
}


if (text != -1){
	PnjDialogue();
}
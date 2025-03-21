/// @description sylvie stuff

switch (room){
	case rMaisonspawn:
	{
		dialogues = ds_map_create();
		if (!global.story_niv1_vase){
			ds_map_add(dialogues, 2, [
				["...", sSylvie],
			]);
		} else{
			ds_map_add(dialogues, 2, [
				["Et qui va nettoyer ton bazar, après...", sSylvie],
			]);	
		}
		break;	
	}
}

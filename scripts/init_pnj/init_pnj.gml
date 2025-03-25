/// @description Script de configuration de base pour un PNJ
/// @param {string} name Nom du PNJ
function init_pnj(name, _pnj_id) {
    nom = name;
	pnj_id = _pnj_id;
	var _data = get_pnj_data(pnj_id); //Valeurs du PNJ dans obj_controller
    affinity = data.affinity;
	narrative_progress = data.narrative_progress;
	data_ref = _data; //Référence directe aux valeurs du PNJ dans obj_controller
    
    if (!variable_instance_exists(id, "dialogue_system")) {
        dialogue_system = new DialogueSystem();
    }
    
	// Charger les données du PNJ depuis oPNJManager
    load_pnj_data(id, pnj_id);
	
    interact = method(id, function() {
        show_debug_message("Interaction avec " + nom);
        
        if (variable_instance_exists(id, "dialogue_system")) {
            dialogue_system.start_dialogue(id);
            
            if (instance_exists(oCamera)) {
                with (oCamera) {
                    follow = other.id;
                }
            }
        } else {
            show_debug_message("ERREUR: dialogue_system n'existe pas pour " + nom);
        }
    });
}
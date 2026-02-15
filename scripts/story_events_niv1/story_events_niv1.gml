/// @description Événements narratifs du Niveau 1 (Arc Début)

/// @function story_niv1_check_sylvie_objects()
/// @description Vérifie si les objets de Sylvie sont cassés (appelé dans rMaisonspawn)
function story_niv1_check_sylvie_objects() {
    // Vérifier si la lampe ET le vase sont cassés
    var lamp_broken = false;
    var vase_broken = false;
    
    if (instance_exists(oLampe1)) {
        lamp_broken = oLampe1.broken;
    }
    
    if (instance_exists(oVase)) {
        vase_broken = oVase.broken && oVase.fallen == 1;
    }
    
    // Si les deux sont cassés
    if (lamp_broken && vase_broken) {
        show_debug_message("Story Niv1: Objets de Sylvie cassés.");
        story_flag("niv1.vase_broken", true);
        
        // Faire progresser la narration de Sylvie
        var sylvie_data = get_pnj_data("sylvie");
        if (sylvie_data.narrative_progress < 3) {
            story_pnj_progress("sylvie", 3);
            show_debug_message("Story Niv1: narrative_progress de Sylvie mis à 3");
        }
    }
}

/// @function story_niv1_on_exit_maisonspawn()
/// @description Événement de sortie de rMaisonspawn
function story_niv1_on_exit_maisonspawn() {
    // Si le joueur sort après avoir cassé les objets
    if (story_check("niv1.vase_broken")) {
        show_debug_message("Story Niv1: Sylvie découvre les dégâts.");
        
        // Sylvie découvre les dégâts
        var sylvie_data = get_pnj_data("sylvie");
        if (sylvie_data.narrative_progress == 2) {
            story_pnj_progress("sylvie", 3);
        }
        
        // Reset le flag
        story_flag("niv1.vase_broken", false);
    }
}

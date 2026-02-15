/// @description Gestionnaire centralisé pour tous les événements de sortie de room
/// @function handle_room_exit_events(exiting_room)
/// @param {asset.GMRoom} exiting_room - La room qu'on quitte
function handle_room_exit_events(exiting_room) {
    // Déléguer au système d'événements déclaratif du StoryManager
    global.story.trigger_room_exit(exiting_room);
}

/// @function register_story_events()
/// @description Enregistre tous les événements d'histoire (appelé au démarrage)
function register_story_events() {
    
    // ===== NIVEAU 1 - Arc Début =====
    
    // Sortie de rMaisonspawn - Sylvie découvre les dégâts
    global.story.on_room_exit(rMaisonspawn, function() {
        if (story_check("niv1.vase_broken")) {
            show_debug_message("Story Niv1: Sylvie découvre les dégâts.");
            
            var sylvie_data = get_pnj_data("sylvie");
            if (sylvie_data.narrative_progress == 3) {
                story_pnj_progress("sylvie", 4);
            }
            
            story_flag("niv1.vase_broken", false);
        }
    });
    
    // ===== AJOUTER D'AUTRES ÉVÉNEMENTS ICI =====
    // global.story.on_room_exit(rAutreRoom, function() { ... });
    // global.story.on_room_enter(rNouvelleZone, function() { ... });
}

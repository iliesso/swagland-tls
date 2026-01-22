/// @description Gestionnaire centralisé pour tous les événements de sortie de room
/// @function handle_room_exit_events(exiting_room)
/// @param {asset.GMRoom} exiting_room - La room qu'on quitte
function handle_room_exit_events(exiting_room) {
    
    // ===== NIVEAU 1 - Arc Début =====
    switch (exiting_room) {
        case rMaisonspawn:
            story_niv1_on_exit_maisonspawn();
            break;
    }
    
    // ===== NIVEAU 2 - À venir =====
    // case rAutreRoom:
    //     story_niv2_on_exit_autreroom();
    //     break;
    
    // ===== ARC SUIVANT =====
    // ...
}

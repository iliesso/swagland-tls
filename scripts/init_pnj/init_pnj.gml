/// @description Script de configuration de base pour un PNJ
/// @param {string} name - Nom affiché du PNJ
/// @param {string} _pnj_id - Identifiant unique pour la persistence
function init_pnj(name, _pnj_id) {
    nom = name;
    pnj_id = _pnj_id;
    
    // Charger les données persistantes depuis le controller
    load_pnj_data(id, pnj_id);
    
    // Créer le système de dialogue et le lier à cette instance
    dialogue_system = new DialogueSystem();
    dialogue_system.set_owner(id);
    
    /// @function interact()
    /// @description Appelée quand le joueur interagit avec ce PNJ
    interact = method(id, function() {
        show_debug_message("Interaction avec " + nom);
        
        // Démarrer le dialogue (le owner est déjà défini)
        dialogue_system.start_dialogue();
        
        // La caméra suit le PNJ pendant le dialogue
        if (instance_exists(oCamera)) {
            oCamera.follow = id;
        }
    });
}
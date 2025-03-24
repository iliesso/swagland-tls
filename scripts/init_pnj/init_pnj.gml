/// @description Script de configuration de base pour un PNJ
function init_pnj(name) {
    
    // Propriétés du PNJ
    nom = name;
    dialogue_system = new DialogueSystem();
    
    
    // Méthode d'interaction
    interact = function() {
        // Active la boîte de dialogue
        dialogue_system.start_dialogue(id);
        
        // Focus de la caméra sur le PNJ
        with (oCamera) {
            follow = other.id;
        }
    };
}
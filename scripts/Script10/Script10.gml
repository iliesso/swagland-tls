/// @description Configuration de base pour un PNJ
function init_pnj() {
    // Hériter des propriétés de base d'un objet interactif
    event_inherited();
    
    // Propriétés du PNJ
    nom = "PNJ sans nom";
    dialogue_system = new DialogueSystem();
    story_progress = 0;
    
    // Configuration de l'interaction
    interact_text = "Parler";
    indicator_offset_y = 32;
    
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
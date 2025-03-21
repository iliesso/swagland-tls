/// @description Poignée de porte

// Hérite de abstract_interactive
event_inherited();

is_locked = false;
key_required = "none";
target_room = -1; //Nom de la room cible (A personnaliser sur l'objet dans la room directement)
targetX = 0; //Coordonnées de la porte dans la room cible (A personnaliser sur l'objet dans la room directement)
targetY = 0; 
camWidth = 320; //Largeur de la caméra par défaut de la room dans laquelle on va (à modifier au cas par cas)


// Surcharge de la méthode d'interaction
function interact() {
    show_debug_message("Porte interaction triggered");
    if (is_locked) {
        // Vérifier si le joueur a la clé appropriée
        var has_key = false;
        
        // Code pour vérifier si le joueur a la clé
        // ...
        
        if (has_key) {
            enter_door();
            // TODO: Jouer un son de déverrouillage
        } else {
            // Afficher un message indiquant que la porte est verrouillée
            // TODO: Jouer un son de porte verrouillée
        }
    } else {
        enter_door();
    }
}

function enter_door() {
    if (target_room != -1) {
        show_debug_message("Target Room: " + string(target_room));
        show_debug_message("targetX: " + string(targetX));
        show_debug_message("targetY: " + string(targetY));
        // Sauvegarder les coordonnées de destination
        global.targetX = targetX;
        global.targetY = targetY;
        global.camWidth = camWidth;

        show_debug_message("Global values set - targetX: " + string(global.targetX) + ", targetY: " + string(global.targetY));
        
        // Désactiver temporairement le contrôle du joueur
        with (oOui) {
            hascontrol = false;
        }
        
        // Transition vers la nouvelle salle
        SlideTransition(TRANS_MODE.GOTO, target_room);
    } else {
        show_debug_message("Error: Target room not set for door object");
    }
}
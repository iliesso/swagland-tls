/// @description Gestion de l'affichage et de la progression du dialogue

// === POSITION DU PORTRAIT (ANIMÉE) ===
var _cam_exists = instance_exists(oCamera);

// Définir la position cible en fonction de la caméra
if (_cam_exists) {
    portrait_target_x = oCamera.x * sprite_x_target;
    portrait_y = oCamera.y * sprite_y_target;
} else {
    portrait_target_x = sprite_x_target_nocam;
    portrait_y = RESOL_H * 0.73;
}

// Position initiale au premier frame (hors écran)
if (portrait_x == 0) {
    portrait_x = _cam_exists ? oCamera.x * 1.8 : RESOL_W * 1.3;
}

// Animation d'entrée (slide)
portrait_x += (portrait_target_x - portrait_x) / speakerEntrance;

// === ANIMATION BOÎTE DE TEXTE ===
animProgress += (1 - animProgress) / 50;
textProgress += global.textSpeed;

x1 = lerp(x1, x1Target, animProgress);
x2 = lerp(x2, x2Target, animProgress);

// === INPUT: AVANCER OU PASSER LE DIALOGUE ===
if (keyboard_check_pressed(global.keyAction) || mouse_check_button_pressed(mb_right)) {
    if (textProgress >= length) {
        // Texte terminé: avancer ou finir
        _advance_or_end_dialogue();
    } else if (textProgress > 2) {
        // Skip l'animation de texte
        textProgress = length;
    }
}

/// @function _advance_or_end_dialogue()
/// @description Avance au prochain message ou termine le dialogue
function _advance_or_end_dialogue() {
    // Support des messages en array (multipages) ou string simple
    var _is_multipage = is_array(msg);
    var _max_pages = _is_multipage ? array_length(msg) : 1;
    
    if (page + 1 < _max_pages) {
        // Page suivante
        page++;
        textProgress = 0;
        length = string_length(_is_multipage ? msg[page] : msg);
    } else {
        // Fin du dialogue - déléguer au DialogueSystem s'il existe
        if (dialogue_system_ref != noone) {
            // Le DialogueSystem gère la suite ou la fin
            if (!dialogue_system_ref.advance_dialogue(pnj_ref)) {
                // Plus de dialogues, détruire l'instance
                _cleanup_and_destroy();
            } else {
                // Nouveau dialogue créé, détruire cette instance
                _cleanup_and_destroy();
            }
        } else {
            // Pas de DialogueSystem (panneau simple), terminer normalement
            player_unlock();
            if (instance_exists(oCamera) && instance_exists(oOui)) {
                oCamera.follow = oOui;
            }
            _cleanup_and_destroy();
        }
    }
}

/// @function _cleanup_and_destroy()
/// @description Nettoie et détruit l'instance
function _cleanup_and_destroy() {
    instance_destroy();
}

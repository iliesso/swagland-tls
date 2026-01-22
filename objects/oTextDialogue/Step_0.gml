/// @description Gestion de l'affichage et de la progression du dialogue

// === ANIMATION DU PORTRAIT (slide depuis la droite) ===
portrait_x += (portrait_target_x - portrait_x) / speakerEntrance;

// === ANIMATION BOÎTE DE TEXTE ===
animProgress += (1 - animProgress) / 50;
textProgress += global.textSpeed;

x1 = lerp(x1, x1Target, animProgress);
x2 = lerp(x2, x2Target, animProgress);

// === INPUT: AVANCER OU PASSER LE DIALOGUE ===
if (keyboard_check_pressed(global.keyAction) || mouse_check_button_pressed(mb_right)) {
    if (textProgress >= length) {
        // Texte terminé: demander au DialogueSystem d'avancer
        if (dialogue_system_ref != noone) {
            // Le DialogueSystem met à jour cette instance ou la détruit
            dialogue_system_ref.advance_dialogue(pnj_ref);
        } else {
            // Pas de DialogueSystem (panneau simple), terminer
            player_unlock();
            if (instance_exists(oCamera) && instance_exists(oOui)) {
                oCamera.follow = oOui;
            }
            instance_destroy();
        }
    } else if (textProgress > 2) {
        // Skip l'animation de texte
        textProgress = length;
    }
}

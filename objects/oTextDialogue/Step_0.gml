/// @description Gestion de l'affichage et de la progression du dialogue

// === ANIMATION DU PORTRAIT (slide depuis la droite) ===
portrait_x += (portrait_target_x - portrait_x) / speakerEntrance;

// === ANIMATION BOÎTE DE TEXTE ===
animProgress += (1 - animProgress) / 50;

x1 = lerp(x1, x1Target, animProgress);
x2 = lerp(x2, x2Target, animProgress);

// === MODE CHOIX: NAVIGATION ET SÉLECTION ===
if (is_choice_mode) {
    var num_choices = array_length(choice_options);
    
    // Navigation haut/bas
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("Z"))) {
        selected_choice_index--;
        if (selected_choice_index < 0) selected_choice_index = num_choices - 1;
    }
    
    if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
        selected_choice_index++;
        if (selected_choice_index >= num_choices) selected_choice_index = 0;
    }
    
    // Validation du choix
    if (keyboard_check_pressed(global.keyAction) || keyboard_check_pressed(vk_enter) || mouse_check_button_pressed(mb_right)) {
        if (dialogue_system_ref != noone) {
            dialogue_system_ref.select_choice(selected_choice_index);
        }
    }
    
    return; // Skip le reste en mode choix
}

// === MODE DIALOGUE NORMAL ===
textProgress += global.textSpeed;

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

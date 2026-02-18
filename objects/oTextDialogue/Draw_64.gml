/// @description Draw portrait, speaker name, black box and text/choices

// === DESSINER LE PORTRAIT DU PNJ ===
if (portrait_sprite != noone && sprite_exists(portrait_sprite)) {
    draw_sprite_ext(
        portrait_sprite,
        0,
        portrait_x,
        portrait_y,
        portrait_scale,   // image_xscale
        portrait_scale,   // image_yscale
        portrait_angle,   // image_angle
        c_white,
        1                 // alpha
    );
}

// === DESSINER LA BOÎTE DE TEXTE ===
draw_sprite_stretched(sBlack, background, x1, y1, x2 - x1, y2 - y1);

// === DESSINER LE NOM DU SPEAKER ===
if (speaker != "") {
    DrawSetText(c_yellow, fDialogue, fa_left, fa_top);
    draw_text(x1 + 20, y2 - 32, speaker);
}

// === MODE CHOIX: AFFICHER LES OPTIONS ===
if (is_choice_mode) {
    var choice_y_start = y1 + 40;
    var choice_spacing = 30;
    
    DrawSetText(c_white, fDialogue, fa_left, fa_top);
    
    for (var i = 0; i < array_length(choice_options); i++) {
        var option = choice_options[i];
        var label = option[0];  // Premier élément = texte du choix
        
        var choice_y = choice_y_start + (i * choice_spacing);
        var choice_x = x1 + 40;
        
        // Surbrillance de l'option sélectionnée
        if (i == selected_choice_index) {
            // Fond de surbrillance
            draw_set_alpha(0.3);
            draw_rectangle(x1 + 30, choice_y - 2, x2 - 30, choice_y + 22, false);
            draw_set_alpha(1);
            
            // Texte en jaune + indicateur
            DrawSetText(c_yellow, fDialogue, fa_left, fa_top);
            draw_text(choice_x - 20, choice_y, ">");
        } else {
            DrawSetText(c_white, fDialogue, fa_left, fa_top);
        }
        
        draw_text(choice_x, choice_y, label);
    }
    
    return; // Skip le rendu de texte normal
}

// === MODE DIALOGUE NORMAL: DESSINER LE TEXTE ===
DrawSetText(c_white, fDialogue, fa_center, fa_top);
var _current_msg = is_array(msg) ? msg[page] : msg;

// Retour à la ligne automatique avec draw_text_ext
var max_width = (x2 - x1) - 60;  // Marges de 30px de chaque côté
var line_height = -1;             // -1 = espacement automatique
draw_text_ext((x1+x2)/2, y1+30, string_copy(_current_msg, 1, textProgress), line_height, max_width);

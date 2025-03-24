/// @description Système de dialogue centralisé pour PNJ
function DialogueSystem() constructor {
    dialogues = ds_map_create();      // Structure pour stocker les dialogues
	current_state = "default";		  // Etat actuel (etat que le pnj va te dire)
    current_dialogue = noone;		  // Lignes à afficher pour l'état actuel
    dialogue_index = 0;				  // Suivi de la progression dans un dialogue
    auto_return_camera = true;        // Rendre la caméra au joueur automatiquement. Peut être modifié par le PNJ ou une cinématique
    
    /// @function add_dialogue_state(state_name, dialogues_array, conditions_script, on_enter_script)
    /// @param {string|real} state_name Id de l'état de dialogue
    /// @param {array} dialogues_array Tableau de strings représentant les dialogues
    /// @param {function} conditions_script (optionnel) Conditions pour activer l'état
    /// @param {function} on_enter_script (optionnel) Script à exécuter à l'entrée de l'état de dialogue
    /// @param {function} on_exit_script (optionnel) Script à exécuter à la sortie de l'état de dialogue
    /// @description Ajoute un état de dialogue. Un état de dialogue est une interaction.
    add_dialogue_state = function(state_name, dialogues_array, conditions_script = undefined, on_enter_script = undefined, on_exit_script = undefined) {
    var state = {
        lines: dialogues_array,
        condition: conditions_script,
        on_enter: on_enter_script,
        on_exit: on_exit_script
    };
    ds_map_add(dialogues, state_name, state);
};

    
    /// @function get_available_state()
    /// @description Retourne l'état disponible le plus prioritaire
    get_available_state = function() {
        // Parcourt les états dans l'ordre (utilise les entiers comme priorité si présents)
        var available_state = "default";
        var numeric_states = [];
        
        var key = ds_map_find_first(dialogues);
        for (var i = 0; i < ds_map_size(dialogues); i++) {
            // Si la clé est un nombre, l'ajouter à la liste des états numériques
            if (is_real(key) && key != 0) {
                array_push(numeric_states, key);
            }
            
            key = ds_map_find_next(dialogues, key);
        }
        
        // Trier les états numériques en ordre décroissant (priorité plus élevée d'abord)
        array_sort(numeric_states, function(a, b) { return b - a; });
        
        // Vérifier chaque état numérique
        for (var i = 0; i < array_length(numeric_states); i++) {
            var state = dialogues[? numeric_states[i]];
            // Si pas de condition ou condition satisfaite
            if (state.condition == undefined || script_execute(state.condition)) {
                return numeric_states[i];
            }
        }
        
        // Si aucun état numérique n'est disponible, renvoyer "default"
        return "default";
    };
    
    start_dialogue = function(pnj_instance) {
        current_state = get_available_state();
        var state = dialogues[? current_state];

        if (state == undefined) {
            show_debug_message("ERREUR: État de dialogue non trouvé: " + string(current_state));
            return false;
        }

        dialogue_index = 0;
        current_dialogue = state.lines;

        // Exécuter le script "on_enter" si défini
        if (state.on_enter != undefined) {
            script_execute(state.on_enter);
        }

        // Bloquer le joueur
        with (oOui) {
            hascontrol = false;
            hsp = 0;
            vsp = 0;
        }

        advance_dialogue(pnj_instance);
        return true;
    };

    
    /// @function advance_dialogue()
    /// @description Avance au prochain dialogue
    advance_dialogue = function(pnj_instance) {
        if (current_dialogue == noone || dialogue_index >= array_length(current_dialogue)) {
            end_dialogue();
            return false;
        }
        
        var line = current_dialogue[dialogue_index];
        
        // Format de ligne: [texte, sprite/son, options...]
        with (instance_create_layer(pnj_instance.x, pnj_instance.y - 16, "Instances", oTextDialogue)) {
            speaker = pnj_instance.nom;
            msg = line[0];
            length = string_length(msg);
            
            // Si un sprite est spécifié
            if (array_length(line) > 1 && sprite_exists(line[1])) {
                pnj_instance.sprite_index = line[1];
            }
            
            // Si un son est spécifié
            if (array_length(line) > 2 && audio_exists(line[2])) {
                audio_play_sound(line[2], 10, false);
            }
        }
        
        dialogue_index++;
        return true;
    };
    
    /// @function end_dialogue()
    /// @description Termine le dialogue
    end_dialogue = function() {
        var state = dialogues[? current_state];
        if (state != undefined && state.on_exit != undefined) {
            script_execute(state.on_exit);
        }

        // Rendre le contrôle au joueur
        with (oOui) {
            hascontrol = true;
        }

        if (auto_return_camera) {
            with (oCamera) {
                follow = oOui;
            }
        }

        current_dialogue = noone;
        dialogue_index = 0;

        return true;
    };
    
    /// @function cleanup()
    /// @description Nettoie les ressources utilisées
    cleanup = function() {
        ds_map_destroy(dialogues);
    };
}
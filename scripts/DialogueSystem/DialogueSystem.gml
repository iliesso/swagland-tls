/// @description Système de dialogue centralisé pour PNJ
/// @version 3.0 - Priorité inversée, options struct, speaker par ligne

function DialogueSystem() constructor {
    // Struct pour stocker les états de dialogue (plus besoin de cleanup!)
    dialogues = {};
    
    // Référence au PNJ propriétaire (défini lors de l'init)
    owner = noone;
    
    // Référence à l'instance oTextDialogue active
    active_textbox = noone;
    
    // État actuel du dialogue
    current_state = "default";
    current_dialogue = noone;
    dialogue_index = 0;
    
    // Options
    auto_return_camera = true;
    auto_save_pnj_data = true;  // Sauvegarde automatique des données PNJ après dialogue
    
    /// @function set_owner(pnj_instance)
    /// @param {Id.Instance} pnj_instance - L'instance du PNJ propriétaire
    /// @description Lie ce DialogueSystem à une instance de PNJ
    set_owner = function(pnj_instance) {
        owner = pnj_instance;
    };
    
    /// @function add_dialogue_state(state_name, dialogues_array, opts)
    /// @param {string|real} state_name - Id de l'état (nombre élevé = plus prioritaire, "default" = fallback)
    /// @param {array} dialogues_array - Tableau de lignes [[texte, sprite?, son?, speaker?], ...]
    /// @param {struct} opts - (optionnel) { condition, on_enter, on_exit }
    add_dialogue_state = function(state_name, dialogues_array, opts = {}) {
        var state = {
            lines: dialogues_array,
            condition: variable_struct_get(opts, "condition"),
            on_enter: variable_struct_get(opts, "on_enter"),
            on_exit: variable_struct_get(opts, "on_exit")
        };
        
        variable_struct_set(dialogues, string(state_name), state);
    };
    
    /// @function get_state(state_name)
    /// @description Récupère un état par son nom (gère les clés numériques)
    get_state = function(state_name) {
        return variable_struct_get(dialogues, string(state_name));
    };
    
    /// @function get_available_state()
    /// @description Retourne l'état disponible le plus prioritaire (numéro élevé = prioritaire)
    get_available_state = function() {
        var keys = variable_struct_get_names(dialogues);
        var numeric_states = [];
        
        // Collecter les états numériques
        for (var i = 0; i < array_length(keys); i++) {
            var key = keys[i];
            if (key == "default") continue;
            
            // Vérifier si la clé est numérique via string_digits
            if (string_digits(key) == key && string_length(key) > 0) {
                array_push(numeric_states, real(key));
            }
        }
        
        // Trier par ordre décroissant (numéro élevé = plus prioritaire)
        array_sort(numeric_states, function(a, b) { return b - a; });
        
        // Retourner le premier état dont la condition est remplie
        for (var i = 0; i < array_length(numeric_states); i++) {
            var state = get_state(numeric_states[i]);
            if (state != undefined) {
                if (state.condition == undefined || state.condition(owner)) {
                    return numeric_states[i];
                }
            }
        }
        
        return "default";
    };
    
    /// @function start_dialogue(pnj_instance)
    /// @param {Id.Instance} pnj_instance - (optionnel) Override du owner
    /// @description Démarre le dialogue approprié
    start_dialogue = function(pnj_instance = noone) {
        // Utiliser l'instance passée ou le owner enregistré
        var pnj = (pnj_instance != noone) ? pnj_instance : owner;
        
        if (pnj == noone || !instance_exists(pnj)) {
            show_debug_message("ERREUR: Aucun PNJ valide pour le dialogue");
            return false;
        }
        
        // Mettre à jour le owner si nécessaire
        if (owner == noone) owner = pnj;
        
        current_state = get_available_state();
        var state = get_state(current_state);

        if (state == undefined) {
            show_debug_message("ERREUR: État de dialogue non trouvé: " + string(current_state));
            return false;
        }

        dialogue_index = 0;
        current_dialogue = state.lines;

        // Exécuter on_enter avec le PNJ en contexte
        if (state.on_enter != undefined) {
            state.on_enter(pnj);
        }

        player_lock();
        advance_dialogue(pnj);
        return true;
    };
    
    /// @function advance_dialogue(pnj_instance)
    /// @description Avance au prochain dialogue
    advance_dialogue = function(pnj_instance = noone) {
        var pnj = (pnj_instance != noone) ? pnj_instance : owner;
        
        if (current_dialogue == noone || dialogue_index >= array_length(current_dialogue)) {
            end_dialogue(pnj);
            return false;
        }
        
        var line = current_dialogue[dialogue_index];
        
        // === DÉTECTION DE CHOIX ===
        // Format choix: { choice: [[label, on_select?, next_lines?], ...] }
        if (is_struct(line) && variable_struct_exists(line, "choice")) {
            var choice_options = line.choice;
            
            // Vérifier si on a déjà une textbox active
            if (active_textbox != noone && instance_exists(active_textbox)) {
                // Passer en mode choix
                active_textbox.is_choice_mode = true;
                active_textbox.choice_options = choice_options;
                active_textbox.selected_choice_index = 0;
                active_textbox.textProgress = 0;  // Reset pour animation
            } else {
                // Créer une nouvelle boîte en mode choix
                var _layer = layer_exists("Instances") ? "Instances" : layer;
                var _x = (pnj != noone && instance_exists(pnj)) ? pnj.x : x;
                var _y = (pnj != noone && instance_exists(pnj)) ? pnj.y - 16 : y;
                var text_instance = instance_create_layer(_x, _y, _layer, oTextDialogue);
                text_instance.pnj_ref = pnj;
                text_instance.dialogue_system_ref = self;
                text_instance.is_choice_mode = true;
                text_instance.choice_options = choice_options;
                text_instance.selected_choice_index = 0;
                
                active_textbox = text_instance;
            }
            
            dialogue_index++;
            return true;
        }
        
        // === LIGNE DE DIALOGUE NORMALE ===
        // Format ligne: [texte, sprite?, son?, speaker?] ou simple string
        var _msg = is_array(line) ? line[0] : line;
        var _length = string_length(_msg);
        
        // Extraire le sprite du portrait si spécifié
        var _portrait_spr = noone;
        if (is_array(line) && array_length(line) > 1 && sprite_exists(line[1])) {
            _portrait_spr = line[1];
        }
        
        // Extraire le speaker par ligne (4ème élément) ou fallback sur pnj.nom
        var _speaker = (pnj != noone && variable_instance_exists(pnj, "nom")) ? pnj.nom : "???";
        if (is_array(line) && array_length(line) > 3 && is_string(line[3])) {
            _speaker = line[3];
        }
        
        // Vérifier si on a déjà une textbox active
        if (active_textbox != noone && instance_exists(active_textbox)) {
            // Mettre à jour l'instance existante
            active_textbox.msg = _msg;
            active_textbox.length = _length;
            active_textbox.textProgress = 0;
            active_textbox.speaker = _speaker;
            active_textbox.is_choice_mode = false;  // Retour au mode normal
            
            // Mettre à jour le portrait seulement si spécifié
            if (_portrait_spr != noone) {
                active_textbox.portrait_sprite = _portrait_spr;
            }
        } else {
            // Créer une nouvelle boîte de dialogue
            var _layer = layer_exists("Instances") ? "Instances" : layer;
            var _x = (pnj != noone && instance_exists(pnj)) ? pnj.x : x;
            var _y = (pnj != noone && instance_exists(pnj)) ? pnj.y - 16 : y;
            var text_instance = instance_create_layer(_x, _y, _layer, oTextDialogue);
            text_instance.speaker = _speaker;
            text_instance.msg = _msg;
            text_instance.length = _length;
            text_instance.pnj_ref = pnj;
            text_instance.dialogue_system_ref = self;
            text_instance.portrait_sprite = _portrait_spr;
            
            // Stocker la référence
            active_textbox = text_instance;
        }
        
        // Jouer le son si spécifié
        if (is_array(line) && array_length(line) > 2 && audio_exists(line[2])) {
            audio_play_sound(line[2], 10, false);
        }
        
        dialogue_index++;
        return true;
    };
    
    /// @function select_choice(choice_index)
    /// @description Traite la sélection d'un choix par le joueur
    /// @param {real} choice_index - Index du choix sélectionné (0-based)
    select_choice = function(choice_index) {
        var pnj = owner;
        
        if (active_textbox == noone || !instance_exists(active_textbox)) {
            return false;
        }
        
        var choice_options = active_textbox.choice_options;
        if (choice_index < 0 || choice_index >= array_length(choice_options)) {
            return false;
        }
        
        var selected_option = choice_options[choice_index];
        
        // Format: [label, on_select?, next_lines?]
        var on_select = (array_length(selected_option) > 1) ? selected_option[1] : undefined;
        var next_lines = (array_length(selected_option) > 2) ? selected_option[2] : undefined;
        
        // Exécuter le callback de sélection
        if (on_select != undefined && is_method(on_select)) {
            on_select(pnj);
        }
        
        // Injecter les lignes de branchement si présentes
        if (next_lines != undefined && is_array(next_lines)) {
            // Insérer les next_lines après l'index actuel
            var new_dialogue = [];
            
            // Copier tout avant dialogue_index
            for (var i = 0; i < dialogue_index; i++) {
                array_push(new_dialogue, current_dialogue[i]);
            }
            
            // Insérer les next_lines
            for (var i = 0; i < array_length(next_lines); i++) {
                array_push(new_dialogue, next_lines[i]);
            }
            
            // Copier tout après dialogue_index
            for (var i = dialogue_index; i < array_length(current_dialogue); i++) {
                array_push(new_dialogue, current_dialogue[i]);
            }
            
            current_dialogue = new_dialogue;
        }
        
        // Avancer au prochain dialogue
        advance_dialogue(pnj);
        return true;
    };
    
    /// @function end_dialogue(pnj_instance)
    /// @description Termine le dialogue proprement
    end_dialogue = function(pnj_instance = noone) {
        var pnj = (pnj_instance != noone) ? pnj_instance : owner;
        var state = get_state(current_state);
        
        // Exécuter on_exit avec le PNJ en contexte
        if (state != undefined && state.on_exit != undefined) {
            state.on_exit(pnj);
        }
        
        // Sauvegarder automatiquement les données du PNJ
        if (auto_save_pnj_data && pnj != noone && instance_exists(pnj)) {
            if (variable_instance_exists(pnj, "pnj_id")) {
                update_pnj_data_from_pnj(pnj);
            }
        }
        
        // Détruire la textbox active
        if (active_textbox != noone && instance_exists(active_textbox)) {
            instance_destroy(active_textbox);
        }
        active_textbox = noone;

        player_unlock();

        if (auto_return_camera && instance_exists(oCamera) && instance_exists(oOui)) {
            oCamera.follow = oOui;
        }

        current_dialogue = noone;
        dialogue_index = 0;

        return true;
    };
    
    /// @function is_in_dialogue()
    /// @description Vérifie si un dialogue est en cours
    is_in_dialogue = function() {
        return current_dialogue != noone;
    };
    
    /// @function cleanup()
    /// @description Plus nécessaire avec les structs, mais gardé pour compatibilité
    cleanup = function() {
        // Les structs sont garbage-collectés automatiquement
        dialogues = {};
    };
}
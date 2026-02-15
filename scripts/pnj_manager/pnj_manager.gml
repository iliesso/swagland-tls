/// @description PNJ Manager + StoryManager centralisé
/// Gestion des PNJ et source unique de vérité pour les flags d'histoire

// ========================================
// STORY MANAGER - SOURCE UNIQUE DE VÉRITÉ
// ========================================

/// @function StoryManager()
/// @description Gestionnaire centralisé des flags d'histoire et événements
function StoryManager() constructor {
    
    // FLAGS D'HISTOIRE - Source unique
    flags = {};
    
    // ÉVÉNEMENTS DE ROOM
    room_exit_events = {};
    room_enter_events = {};
    
    /// @function flag_set(name, value)
    flag_set = function(name, value) {
        flags[$ name] = value;
    };
    
    /// @function flag_get(name, default_val)
    flag_get = function(name, default_val = undefined) {
        return variable_struct_exists(flags, name) ? flags[$ name] : default_val;
    };
    
    /// @function flag_check(name)
    flag_check = function(name) {
        return bool(flag_get(name, false));
    };
    
    /// @function on_room_exit(room_id, callback)
    on_room_exit = function(room_id, callback) {
        var key = string(room_id);
        if (!variable_struct_exists(room_exit_events, key)) {
            room_exit_events[$ key] = [];
        }
        array_push(room_exit_events[$ key], callback);
    };
    
    /// @function trigger_room_exit(room_id)
    trigger_room_exit = function(room_id) {
        var key = string(room_id);
        if (variable_struct_exists(room_exit_events, key)) {
            var callbacks = room_exit_events[$ key];
            for (var i = 0; i < array_length(callbacks); i++) {
                callbacks[i]();
            }
        }
    };
    
    /// @function pnj_set_progress(pnj_id, progress)
    pnj_set_progress = function(pnj_id, progress) {
        var data = get_pnj_data(pnj_id);
        data.narrative_progress = progress;
        
        // Sync avec l'instance
        with (all) {
            if (variable_instance_exists(id, "pnj_id") && self.pnj_id == pnj_id) {
                narrative_progress = progress;
                break;
            }
        }
    };
}

// Instance globale (créée au chargement du script)
global.story = new StoryManager();

// ========================================
// API SIMPLIFIÉE
// ========================================

/// @function story_flag(name, value)
/// @param {string} name - Nom du flag
/// @param {any} value - (optionnel) Si fourni, set, sinon get
/// @return {any} La valeur du flag
function story_flag(name, value = undefined) {
    if (value == undefined) {
        return global.story.flag_get(name);
    } else {
        global.story.flag_set(name, value);
        return value;
    }
}

/// @function story_check(name)
/// @param {string} name - Nom du flag
/// @return {bool} true si le flag est truthy
function story_check(name) {
    return global.story.flag_check(name);
}

/// @function story_pnj_progress(pnj_id, progress)
/// @param {string} pnj_id - ID du PNJ
/// @param {real} progress - Nouveau niveau de progression
function story_pnj_progress(pnj_id, progress) {
    global.story.pnj_set_progress(pnj_id, progress);
}

// ========================================
// PNJ MANAGER - FONCTIONS EXISTANTES
// ========================================

/// @function get_pnj_data(pnj_id)
/// @param pnj_id {string}
/// @return {struct} les données du PNJ
function get_pnj_data(pnj_id) {
    if (!variable_struct_exists(oController.pnj_states, pnj_id)) {
        var data = {
            affinity: 0,
            narrative_progress: 1  // Démarre à 1 (DialogueSystem ignore l'état 0)
        };
        variable_struct_set(oController.pnj_states, pnj_id, data);
    }
    return oController.pnj_states[$ pnj_id];
}

/// @function load_pnj_data(instance, pnj_id) Permet de mettre à jour les variables d'état du PNJ avec celles dans le controller.
/// @param instance {object} - l’instance du PNJ
/// @param pnj_id {string} - id du pnj dans le controller (ex : "sage_montagne")
function load_pnj_data(inst, pnj_id) {
    var data = get_pnj_data(pnj_id);
    inst.affinity = data.affinity;
    inst.narrative_progress = data.narrative_progress;
    inst.pnj_id = pnj_id;
}

/// @function update_pnj_data_from_pnj(instance)
/// @param instance {object} - instance ayant les vars .pnj_id, .affinity, .narrative_progress
function update_pnj_data_from_pnj(inst) {
    if (!variable_instance_exists(inst, "pnj_id")) return;
    var data = get_pnj_data(inst.pnj_id);
    data.affinity = inst.affinity;
    data.narrative_progress = inst.narrative_progress;
}

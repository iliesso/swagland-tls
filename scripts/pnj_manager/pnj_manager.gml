/// @description Fonctions du PNJ Manager.
/// Progression narrative et affinité des PNJ centralisées dans l'objet controller.
/// @function get_pnj_data(pnj_id)
/// @param pnj_id {string}
/// @return {struct} les données du PNJ
function get_pnj_data(pnj_id) {
    if (!ds_map_exists(oController.pnj_states, pnj_id)) {
        var data = {
            affinity: 0,
            narrative_progress: 0
        };
        ds_map_add(oController.pnj_states, pnj_id, data);
    }
    return oController.pnj_states[? pnj_id];
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

/// @description A basic sign — utilise DialogueSystem unifié
/// @parent abstract_interactive

event_inherited();

// Pas de nom de speaker pour les panneaux
nom = "";

// Créer le DialogueSystem (sans persistance PNJ)
dialogue_system = new DialogueSystem();
dialogue_system.set_owner(id);
dialogue_system.auto_save_pnj_data = false;
dialogue_system.auto_return_camera = true;

// "text" est défini par le room editor (propriété d'instance)
// Enregistrer comme état default
dialogue_system.add_dialogue_state("default", [
    [text]
]);

// Override interact() pour utiliser le DialogueSystem
interact = method(id, function() {
    if (dialogue_system.is_in_dialogue()) return;
    dialogue_system.start_dialogue();
    if (instance_exists(oCamera)) oCamera.follow = id;
});

/// @description Femme de Philippe


// Héritage des propriétés du parent
event_inherited();
init_pnj("Sylvie", "sylvie");

#region Dialogue

// État par défaut (fallback)
dialogue_system.add_dialogue_state("default", [
    ["Quoi, encore ?", sSylvie]
]);

// État 1: Première rencontre ("...")
dialogue_system.add_dialogue_state(1, [
    ["...", sSylvie]
], {});

// Objets cassés
dialogue_system.add_dialogue_state(3, [
    ["Et c'est moi qui vais nettoyer tes betises...", sSylvie]
], {
    condition: function(pnj) { return pnj.narrative_progress == 3; }
});

// Objets réparés
dialogue_system.add_dialogue_state(4, [
    ["J'ai enfin repare tes betises.", sSylvie]
], {
    condition: function(pnj) { return pnj.narrative_progress == 4; },
    on_exit: function(pnj) { pnj.narrative_progress = 1; }
});
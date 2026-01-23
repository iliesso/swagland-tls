/// @description Femme de Philippe


// Héritage des propriétés du parent
event_inherited();
init_pnj("Sylvie", "sylvie");

#region Dialogue

// État par défaut (fallback)
dialogue_system.add_dialogue_state("default", [
    ["Qu'il fait beau.", sSylvie]
]);

// État 0: Première rencontre
dialogue_system.add_dialogue_state(1, [
    ["...", sSylvie]
],
function(pnj) {
    return pnj.narrative_progress == 0;
},
undefined,
function(pnj) {
    pnj.narrative_progress = 0;
});

// État 2: Objets cassés
dialogue_system.add_dialogue_state(2, [
    ["Et c'est moi qui vais nettoyer tes bêtises...", sSylvie]
], 
function(pnj) {
    return pnj.narrative_progress == 2;
},
undefined,
function(pnj) {
    pnj.narrative_progress = 2;
});

// État 3: Objets réparés
dialogue_system.add_dialogue_state(3, [
    ["J'ai enfin réparé tes bêtises.", sSylvie]
], 
function(pnj) {
    return pnj.narrative_progress == 3;
},
undefined,
function(pnj) {
    pnj.narrative_progress = 0;
});
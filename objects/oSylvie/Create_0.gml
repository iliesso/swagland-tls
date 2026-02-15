/// @description Femme de Philippe


// Héritage des propriétés du parent
event_inherited();
init_pnj("Sylvie", "sylvie");

#region Dialogue

// État par défaut (fallback)
dialogue_system.add_dialogue_state("default", [
    ["Qu'il fait beau.", sSylvie]
]);

// État 1: Première rencontre ("...")
dialogue_system.add_dialogue_state(1, [
    ["...", sSylvie]
],
function(pnj) {
    // Condition: progress == 1 ET le saut n'a pas été vu
    return pnj.narrative_progress == 1 && !story_check("niv1.sylvie_saut_vu");
},
undefined,
function(pnj) {
    pnj.narrative_progress = 1;
});

// État 2: Réaction au saut (priorité < état 3 des objets cassés)
dialogue_system.add_dialogue_state(2, [
    ["Beau saut.", sSylvie]
],
function(pnj) {
    // Seulement si saut vu ET pas d'objets cassés (priorité)
    return story_check("niv1.sylvie_saut_vu") && pnj.narrative_progress < 3;
},
undefined,
function(pnj) {
    // Retour à l'état 1 après avoir parlé du saut
    story_flag("niv1.sylvie_saut_vu", false);
    pnj.narrative_progress = 1;
});

// État 3: Objets cassés
dialogue_system.add_dialogue_state(3, [
    ["Et c'est moi qui vais nettoyer tes bêtises...", sSylvie]
], 
function(pnj) {
    return pnj.narrative_progress == 3;
},
undefined,
function(pnj) {
    pnj.narrative_progress = 3;
});

// État 4: Objets réparés
dialogue_system.add_dialogue_state(4, [
    ["J'ai enfin réparé tes bêtises.", sSylvie]
], 
function(pnj) {
    return pnj.narrative_progress == 4;
},
undefined,
function(pnj) {
    pnj.narrative_progress = 1;
});
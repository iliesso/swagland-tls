/// @description Montagnard songeur. Mari de Sylvie.

// Héritage des propriétés du parent
event_inherited();
init_pnj("Philippe", "philippe");

#region Dialogue

// État par défaut (fallback)
dialogue_system.add_dialogue_state("default", [
    ["Allez, va gambader ailleurs, mon grand.", sPhilippe]
]);

// État 1: Première rencontre
dialogue_system.add_dialogue_state(1, [
    ["Bonjour mon grand. Moi c'est Philippe, et toi?", sPhilippe],
    ["Alors comme ça, tu t'appelles " + string(global.playerName) + "...", sPhilippe],
    ["Fais attention aux falaises, c'est dangereux ici.", sPhilippe]
], 
function(pnj) {
    return pnj.narrative_progress == 0;
},
undefined,
function(pnj) {
    pnj.narrative_progress = 1;
});

// État 2: Après première rencontre
dialogue_system.add_dialogue_state(2, [
    ["J'aime rester ici, le matin.", sPhilippe],
    ["Je me sens libre, dans la nature.", sPhilippe]
], 
function(pnj) {
    return pnj.narrative_progress == 1;
});

#endregion
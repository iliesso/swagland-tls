/// @description Montagnard songeur. Mari de Sylvie.

// Héritage des propriétés du parent
event_inherited();
init_pnj("Philippe", "philippe");

#region Dialogue

dialogue_system.add_dialogue_state("default", [
    ["Allez, va gambader ailleurs, mon grand.", sPhilippe]
]);

dialogue_system.add_dialogue_state(1, [
    ["Bonjour mon grand. Moi c'est Philippe, et toi?", sPhilippe],
    ["Alors comme ça, tu t'appelles " + string(global.playerName) + "...", sPhilippe],
    ["Fais attention aux falaises, c'est dangereux ici.", sPhilippe]
], function(){
    return narrative_progress == 0;
});

dialogue_system.add_dialogue_state(2, [
    ["J'aime rester ici, le matin.", sPhilippe],
    ["Je me sens libre, dans la nature.", sPhilippe]
], function() {
    return narrative_progress == 1;
});


#endregion
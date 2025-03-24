/// @description Montagnard songeur. Mari de Sylvie.

// Héritage des propriétés du parent
event_inherited();
init_pnj("Philippe");

#region Dialogue

dialogue_system.add_dialogue_state("default", [
    ["Allez, va gambader ailleurs, mon grand.", sPhilippe]
]);

dialogue_system.add_dialogue_state(1, [
    ["Bonjour mon grand. Moi c'est Philippe, et toi?", sPhilippe],
    ["Alors comme ça, tu t'appelles " + string(global.playerName) + "...", sPhilippe],
    ["Fais attention aux falaises, c'est dangereux ici.", sPhilippe]
], function() {
    return other.story_progress == 0;
});

dialogue_system.add_dialogue_state(2, [
    ["J'aime rester ici, le matin.", sPhilippe],
    ["Je me sens libre, dans la nature.", sPhilippe]
], function() {
    return other.story_progress == 1;
});

dialogue_system.add_dialogue_state(3, [
    ["...", sPhilippe]
], function() {
    return other.story_progress == 2;
});


#endregion
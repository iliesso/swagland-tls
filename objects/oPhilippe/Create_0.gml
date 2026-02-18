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
    ["Alors comme ca, tu t'appelles " + string(global.playerName) + "...", sPhilippe],
    ["Fais attention aux falaises, c'est dangereux ici.", sPhilippe]
], {
    condition: function(pnj) { return pnj.narrative_progress == 1; },
    on_exit: function(pnj) { pnj.narrative_progress = 2; }
});

// État 2: Après première rencontre
dialogue_system.add_dialogue_state(2, [
    ["J'aime rester ici, le matin.", sPhilippe],
    ["Je me sens libre, dans la nature.", sPhilippe]
], {
    condition: function(pnj) { return pnj.narrative_progress == 2; },
    on_exit: function(pnj) { pnj.narrative_progress = 10; }
});

// État 10: TEST - Exemple de choix
dialogue_system.add_dialogue_state(10, [
    ["Dis-moi, que penses-tu de la montagne?", sPhilippe],
    
    // CHOIX (struct avec clé "choice")
    { choice: [
        ["C'est magnifique!", function(pnj) { 
            pnj.affinity += 1;
            show_debug_message("Philippe affinity: " + string(pnj.affinity));
        }],
        
        ["Bof, rien de special.", function(pnj) { 
            story_flag("philippe_vexe", true);
            show_debug_message("Philippe est vexé!");
        }, [
            ["Tu me blesses...", sPhilippe]  // Ligne unique à ce choix
        ]]
    ]},
    
    ["Hmm, je vois...", sPhilippe],
    ["En tout cas, je les aime particulièrement, ces montagnes. et la je vais te mettre un tunnel de zinzin pour voir jusqu'ou le truc arrete la discussion enfin je veux dire combien de mon texte loge dans la boite de dialogue parce que j'ai l'impression que ca peut durer un max donc faut doser un peu la chef tes pas d'accord moi oui enfin bref.", sPhilippe]
], {
    condition: function(pnj) { return pnj.narrative_progress == 10; },
    on_exit: function(pnj) { pnj.narrative_progress = 2; }
});

#endregion
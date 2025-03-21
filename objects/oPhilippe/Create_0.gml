/// @description Montagnard songeur. Mari de Sylvie.

// Héritage des propriétés du parent
event_inherited();
indic = noone;
nom = "Philippe";
story_progress = 0;

#region Dialogue

page = 0;
dialogues = -1;
debug = 0;

dialogue_step = 0; // État du dialogue, commence à 0

// Création de la structure des dialogues
dialogues = ds_map_create();

// Dialogues pour l'état 1
ds_map_add(dialogues, 1, [
    ["Bonjour mon grand. Moi c'est Philippe, et toi?", sPhilippe],
    ["Alors comme ça, tu t'appelles " + string(global.playerName) + "...", sPhilippe],
    ["Fais attention aux falaises, c'est dangereux ici.", sPhilippe],
]);

ds_map_add(dialogues, 2, [
	["J'aime rester ici, le matin.", sPhilippe],
	["Je me sens libre, dans la nature.", sPhilippe],
])

ds_map_add(dialogues, 3, [
	["...", sPhilippe],
])

ds_map_add(dialogues, "default", [
	["Allez, va gambader ailleurs, mon grand.", sPhilippe],
])

#endregion
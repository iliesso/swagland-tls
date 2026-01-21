/// @description Boîte de dialogue - affiche le texte d'un PNJ

// === RÉFÉRENCES (définies par DialogueSystem) ===
pnj_ref = noone;              // Instance du PNJ qui parle
dialogue_system_ref = noone;  // Référence au DialogueSystem pour callbacks

// === SPEAKER / PORTRAIT ===
speaker = "PNJ";              // Nom du PNJ (pour affichage texte)
portrait_sprite = noone;      // Sprite du portrait à afficher
speakerEntrance = 15;         // Vitesse d'entrée du portrait (higher = slower)
sprite_x_target_nocam = RESOL_W * 0.7;
sprite_x_target = 1.15;
sprite_y_target = 1.095;

// Position du portrait (animée)
portrait_x = 0;
portrait_y = 0;
portrait_target_x = 0;

// === ANIMATION BOÎTE ===
x1 = display_get_gui_width() / 2;
y1 = 0;
x2 = display_get_gui_width() / 2;
y2 = display_get_gui_height() / 4;

x1Target = 0;
x2Target = display_get_gui_width();

animProgress = 0;
textProgress = 0;

// === MESSAGE ===
page = 0;
msg = "...";
length = 0;
background = 0;
size = 50;

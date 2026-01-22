/// @description Boîte de dialogue - affiche le texte d'un PNJ

// === RÉFÉRENCES (définies par DialogueSystem) ===
pnj_ref = noone;              // Instance du PNJ qui parle
dialogue_system_ref = noone;  // Référence au DialogueSystem pour callbacks

// === SPEAKER / PORTRAIT ===
speaker = "PNJ";              // Nom du PNJ (pour affichage texte)
portrait_sprite = noone;      // Sprite du portrait à afficher
speakerEntrance = 12;         // Vitesse d'entrée du portrait (higher = slower)

// Position du portrait en coordonnées GUI
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();
portrait_scale = 5;           // Taille du portrait
portrait_x = _gui_w + 100;    // Position initiale (hors écran à droite)
portrait_y = _gui_h * 0.65;   // Position verticale
portrait_target_x = _gui_w * 0.82;  // Position cible
portrait_angle = 15;          // Légère inclinaison

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

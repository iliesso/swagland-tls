/// @description Initialisation des variables d'interaction

// Peut-on interagir avec l'objet ?
can_interact = true;

// Texte à afficher quand on est proche (optionnel)
interact_text = "";

// Distance verticale de l'indicateur par rapport au centre de l'objet
indicator_offset_y = 16;

// Fonction appelée lors de l'interaction
// Cette fonction doit être redéfinie dans les objets enfants
function interact() {
    // Code par défaut, à surcharger dans les enfants
    show_debug_message("Interaction avec " + object_get_name(object_index));
}

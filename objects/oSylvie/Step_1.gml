/// @description Sylvie observe le joueur

// Observer le joueur sauter dans sa maison
if (instance_exists(oOui)) {
    // Détecter si le joueur vient de sauter (transition de on_ground à !on_ground)
    if (oOui.jumped && !story_check("niv1.sylvie_saut_vu")) {
        story_flag("niv1.sylvie_saut_vu", true);
        show_debug_message("Story Niv1: Sylvie a vu le saut");
    }
}
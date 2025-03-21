/**@description puts indic marker on top of object, 
* then on keyboard press, destroy indic, 
* show dialogue with emotion sprite and track local progress
*/

function PnjDialogue() {
    if (instance_exists(oOui)) {
        if (point_in_circle(oOui.x, oOui.y, x, y, 48)) {  // 48 = indication radius
            if (!instance_exists(oTextDialogue)) {        // if text doesn't already exist
                if (!instance_exists(oIndic)) {
                    indic = instance_create_layer(x, y - 16, layer, oIndic);
                }
                
                // On interact key press
                if (keyboard_check_pressed(global.keyAction) || mouse_check_button_pressed(mb_right)) {
                    instance_destroy(indic);
                    
                    // *** NOUVEAU SYSTEME DE DIALOGUE ***
                    with (oOui) {
                        hascontrol = false;
                        hsp = 0;
                        vsp = 0;
					}

                        var _current_story = story_progress;  // Utilisation de la variable locale
						var _current_dialogues = [];
						
                        // Vérifie si l'état du dialogue existe
                        if (ds_map_exists(dialogues, _current_story)) {
                            _current_dialogues = dialogues[? _current_story];
                        } else {
                            _current_dialogues = dialogues[? "default"];
                        }

                        // Sélection de la ligne de dialogue
                        if (dialogue_index < array_length(_current_dialogues)) {
                            var _current_entry = _current_dialogues[dialogue_index];

                            // Affiche le texte et modifie le sprite
                            sprite_index = _current_entry[1];  //Le sprite de la ligne

                            // Création de la boîte de dialogue
                            with (instance_create_layer(x, y - 16, layer, oTextDialogue)) {
                                speaker = object_get_name(other.object_index);
                                msg = _current_entry[0];  //Le texte de la ligne
                                length = string_length(msg);
                            }
                            
                            dialogue_index++;
                        } else {
                            dialogue_index = 0;  // Réinitialisation après le dernier dialogue
                            story_progress += 1;  // Incrémente la progression de CE PNJ
                        }
                    }
                    
                    // Camera focus on PNJ
                    with (oCamera) {
                        follow = other.id;
                    }
                }
            }
        } else {
            if (instance_exists(indic)) {
                instance_destroy(indic);
            }
        }
    }


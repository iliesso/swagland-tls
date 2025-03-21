#region //key binds, controller and gamepad management

if (hascontrol = true)
{
	
	key_right = keyboard_check(vk_right) || keyboard_check(global.keyRight); //keyboard_check(ord("D")) default
	key_left = keyboard_check(vk_left) || keyboard_check(global.keyLeft); //keyboard_check(ord("Q")) default
	key_up = keyboard_check(global.keyJump);
	key_sprint = keyboard_check(global.keySprint);

	if (key_left) || (key_right) || (key_up) 
	{
		controller = 0;	
	}

	if (abs(gamepad_axis_value(0,gp_axislh)) > 0.2)
	{
		key_left = abs(min(gamepad_axis_value(0,gp_axislh),0));
		key_right = max(gamepad_axis_value(0,gp_axislh),0);
		controller = 1;
	}

	if (gamepad_button_check_pressed(0,gp_face1))
	{
		key_up = 1;
		controller = 1;
	}


	//input and movement link
	var _direction = key_right - key_left;
	hsp = _direction * (walkspd + (key_sprint*key_sprint)); //Walks towards left or right depending if "directio" == 1 or -1. If player sprinting, add sprint speed.
	

	//Jump ledge grace time
	if (!on_ground){
		if (canjump > 0){
			
			canjump -= 1;
			
			if (jumped == false){
				
				if (key_up){
					
					vsp = -jumpspd;   //Jump
					jumped = true;
					
				}
			}
		}
	} else{
		jumped = false;
		canjump = buffer_max;
	}
	
	//Jump buffer grace time
	if (key_up){ buffer_counter = buffer_max; }
	
	if (buffer_counter > 0){
		
		buffer_counter -= 1;
		
		if (on_ground){
			
			vsp = -jumpspd;
			buffer_counter = 0;
			jumped = true;
			
		}
	}
	
	if (vsp < 0 && (!key_up)){
		vsp += grv;	   //if player stops pressing "jump", stop going higher.
	}
	
	
	/* 
	canjump -= 1; 
	if (canjump > 0 && (key_up != 0)) //If player standing on the ground & jumping
	{ 
		
		buffer_counter = buffer_max; //set jump buffer when jumping
		canjump = 0;   //Can not jump anymore, has to touch ground again.
		
	}
	
	if (vsp < 0 && (!key_up)){
		vsp += grv;	   //if player stops pressing "jump", stop going higher.
	}*/
}

//if hascontrol == false
else  
{
	key_right = 0;
	key_left = 0;
	key_up = 0;
}



if (vsp < fallspeed) {
	vsp += grv;	
}

#endregion


#region //collision

//If player in the air or on ground checking
if (place_meeting(x,y+1,oWall)){
	on_ground = true;
} else {
	on_ground = false;
}


//horizontal collision

if place_meeting(x+hsp, y, oWall)
{
	while (!place_meeting(x+sign(hsp), y, oWall))
	{
			x += sign(hsp);
	}
	hsp = 0;
}
x+= hsp;

//vertical collision

if (place_meeting(x, y+vsp, oWall))
{
	while (!place_meeting(x, y+sign(vsp), oWall))  //If player close to touching the ground, pull him exactly on the ground.
	{
			y += sign(vsp);
	}
	vsp = 0;
}
y+= vsp;

#endregion


#region //sprite animation

if (!on_ground)    //if in the air
{
	sprite_index = 	sOuiFall;
	image_speed = 0;      //not animating: only use wanted frame
	
	if (sign(vsp)>0) {   //if falling use fall frame, if going up us going up frame
		image_index = 0;	
	} else {
		image_index = 1;
	}
	
} 
else
{	
	image_speed = 1;
	if (hsp == 0)             //if standing
	{
		sprite_index = currentS;
	}
	else                      //if running
	{
		sprite_index = sOuiRun;
	}
}

if (hsp != 0) image_xscale = sign(hsp);   //flip sprite horizontally according to facing side

#endregion

#region //Interaction radius

var near_interactives_list = ds_list_create();
var _nearest_interactive = noone;
var _best_dist = 999999;

// Récupérer toutes les instances interactives dans le rayon
with (abstract_interactive)
{
    if (distance_to_object(oOui) <= global.interactionRadius)
    {
        ds_list_add(near_interactives_list, id);
    }
}

for (var i = 0; i < ds_list_size(near_interactives_list); i++)
{
    var _inst = ds_list_find_value(near_interactives_list, i);
    
    // Vérifier si l'instance est dans la direction où regarde le joueur
    if (image_xscale == 1) {
        // REGARDE A DROITE, on veut un objet à x >= x du joueur
        if (_inst.x >= x)
        {
            var d = point_distance(x, y, _inst.x, _inst.y);
            if (d < _best_dist) {
                _best_dist = d;
                _nearest_interactive = _inst;
            }
        }
    } else {
        // REGARDE A GAUCHE , on veut un objet à x <= x du joueur
        if (_inst.x <= x)
        {
            var d = point_distance(x, y, _inst.x, _inst.y);
            if (d < _best_dist) {
                _best_dist = d;
                _nearest_interactive = _inst;
            }
        }
    }
}

// Si aucun objet n'est trouvé dans la direciton que le joueur regarde, on vérifie si un objet est derrière lui dans un petit rayon (zone de recul)
if (_nearest_interactive == noone)
{
	//Juste prendre l'abstract_interactive le plus proche si il est dans un rayon de global.interactive_radius_recoil_zone
	for (var i = 0; i < ds_list_size(near_interactives_list); i++)
	{
		var _inst = ds_list_find_value(near_interactives_list, i);
		var d = point_distance(x, y, _inst.x, _inst.y);
		if (d < global.interaction_radius_recoil_zone && d < _best_dist) {
			_best_dist = d;
			_nearest_interactive = _inst;
		}
	}
}

// Si un objet est trouvé, on positionne l'indicateur dessus et on peut interagir
if (_nearest_interactive != noone)
{
    // Vérifier si indicator_offset_y existe, sinon utiliser une valeur par défaut
    var offset_y = 16; // Valeur par défaut
    if (variable_instance_exists(_nearest_interactive, "indicator_offset_y")) {
        offset_y = _nearest_interactive.indicator_offset_y;
    } else {
        show_debug_message("WARNING: indicator_offset_y not found in " + object_get_name(_nearest_interactive.object_index) + ". Using default value.");
    }
    
    // On affiche l'indicateur au-dessus de _nearest_interactive
    if (!instance_exists(indic_id)) {
        indic_id = instance_create_layer(
            _nearest_interactive.x, 
            _nearest_interactive.y - offset_y,
            "Instances",
            oIndic
        );
    }
    else {
        // MàJ position
        indic_id.x = _nearest_interactive.x;
        indic_id.y = _nearest_interactive.y - offset_y;
    }

    // Afficher le texte d'interaction si défini
    // Vérifier si la variable existe et n'est pas vide
    if (variable_instance_exists(_nearest_interactive, "interact_text") && _nearest_interactive.interact_text != "") {
        draw_set_font(fDialogue);
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_text(indic_id.x, indic_id.y - 10, _nearest_interactive.interact_text);
    }
    
    // Vérifier si la méthode d'interaction existe
    if (keyboard_check_pressed(global.keyAction)) {
        with (_nearest_interactive) {
            // Vérifier can_interact
            var can_interact_value = true;
            if (variable_instance_exists(id, "can_interact")) {
                can_interact_value = can_interact;
            } else {
                show_debug_message("WARNING: can_interact not found in " + object_get_name(object_index) + ". Using default value (true).");
            }
            
            if (can_interact_value) { 
                show_debug_message("Interacting with: " + object_get_name(object_index));
                
                // Vérifier que la méthode interact existe
                if (is_method(self.interact)) {
                    interact();
                } else {
                    show_debug_message("ERROR: interact() method not found in " + object_get_name(object_index));
                }
            }
        }
    }
}
else {
    // Si aucun objet proche n'est trouvé, on supprime l'indicateur
    if (instance_exists(indic_id)) {
        with (indic_id) instance_destroy();
    }
}

#endregion

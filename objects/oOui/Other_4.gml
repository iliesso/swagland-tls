/// @description New room: Autosave, rétablir controle

#region save
//Overwrite old save

if (file_exists(SAVEFILE)){
	file_delete(SAVEFILE);
}

//create new save

var file;
file = file_text_open_write(SAVEFILE);
file_text_write_real(file,room);
file_text_close(file);

#endregion

#region control


// Vérifier si des coordonnées de destination sont définies
if (variable_global_exists("targetX") && variable_global_exists("targetY")) {
    x = global.targetX;
    y = global.targetY;
    
    // Réinitialiser pour éviter des problèmes avec les futures transitions
    //global.targetX = 0;
    //global.targetY = 0;
}

// Rétablir le contrôle
hascontrol = true;

#endregion
/// @description when damage received

draw_self();

while (flashCounter > 0){
	
	if (flash > 0) {
		
		flash -= 1;
		shader_set(shWhite);
		draw_self();
		shader_reset();
		
	}
	flash = 6;
	flashCounter -= 1;
}
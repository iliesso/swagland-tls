/// @desc DrawSetText(color, font, halign, valign)
/// @arg color
/// @arg font
/// @arg halign
/// @arg valign
// Draw text with color, font, alignment directly instead of writing 4 lines each time


function DrawSetText(){
	draw_set_color(argument0);
	draw_set_font(argument1);
	draw_set_halign(argument2);
	draw_set_valign(argument3);
}
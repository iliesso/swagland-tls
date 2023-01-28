/// @description écrire du texte dans la textbox

draw_sprite(sTextboxGun, 0, x,y);

draw_set_color(c_white);
draw_set_font(fMenu);
draw_text_ext(x,y, texte[page], strHeight, boxWidth);


//Player choice
if (hoverno){
	draw_set_color(c_yellow);
} else {
	draw_set_color(c_white);
}
draw_text_ext(x-100, y+67, "Non!!", choiceHeight, boxWidth);

if (hoveryes){
	draw_set_color(c_yellow);
} else {
	draw_set_color(c_white);
}
draw_text_ext(x+100, y+67, "Oui...", choiceHeight, boxWidth);

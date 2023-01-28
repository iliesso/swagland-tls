/// @description draw text box when sign read

//Draw rectangle

//largeur du rectangle
var halfw = w / 2; 

draw_set_color(c_black);
draw_set_alpha(0.5);     //trensparency
draw_roundrect_ext(x-halfw-border, y-h-(border*2),x+halfw+border, y-1, radiusx, radiusy, false);

draw_sprite(sMarker,0,x,y);
draw_set_alpha(1);

//Draw text
DrawSetText(c_white, fSign, fa_center, fa_top);
draw_text(x,y-h-border, text_current);
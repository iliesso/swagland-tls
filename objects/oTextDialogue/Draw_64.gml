/// @description Draw black box and text

draw_sprite_stretched(sBlack, background, x1, y1, x2 - x1, y2 - y1);
DrawSetText(c_white, fDialogue, fa_center, fa_top);
draw_text((x1+x2)/2, y1+30, string_copy(msg, 1, textProgress));

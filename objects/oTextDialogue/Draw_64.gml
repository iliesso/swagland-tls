/// @description Draw portrait, black box and text

// === DESSINER LE PORTRAIT DU PNJ ===
if (portrait_sprite != noone && sprite_exists(portrait_sprite)) {
    draw_sprite_ext(
        portrait_sprite,
        0,
        portrait_x,
        portrait_y,
        portrait_scale,   // image_xscale
        portrait_scale,   // image_yscale
        portrait_angle,   // image_angle
        c_white,
        1                 // alpha
    );
}

// === DESSINER LA BOÎTE DE TEXTE ===
draw_sprite_stretched(sBlack, background, x1, y1, x2 - x1, y2 - y1);
DrawSetText(c_white, fDialogue, fa_center, fa_top);

// Support string simple ou array de messages
var _current_msg = is_array(msg) ? msg[page] : msg;
draw_text((x1+x2)/2, y1+30, string_copy(_current_msg, 1, textProgress));

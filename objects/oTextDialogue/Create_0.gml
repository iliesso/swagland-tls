/// @description text bails (panneau)
/*
spdSlow = 0.1;
spdNormal = 0.25;
spdFast = 0.7;
spd = spdNormal;

letters = 0;

text = "Wesh la famille!\n...\nVoila quoi...";

length = string_length(text);

text_current = "";

w = 0;
h = 0;
border = 10;

radiusx = 15;
radiusy = 15;
*/

//NPC at the origin
speaker = "oPhilippe";
speakerEntrance = 15;  //higher = SLOWER
sprite_x_target_nocam = RESOL_W*0.7;
sprite_x_target = 1.15;
sprite_y_target = 1.095;
spr = noone

//blackbox coordinates
x1 = display_get_gui_width()/2;
y1 = 0;
x2 = display_get_gui_width()/2;
y2 = display_get_gui_height()/4;

x1Target = 0;
x2Target = display_get_gui_width();

animProgress = 0;
textProgress = 0;

//message parameters
page = 0;
msg = ["Lorem Ipsum... Voilà quoi."];
length = 0; // string_length(msg);
background = 0;
size = 50;

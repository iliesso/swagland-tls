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
//blackbox coordinates
x1 = display_get_gui_width()/2;
y1 = 2*(display_get_gui_height()/3);
x2 = display_get_gui_width()/2;
y2 = display_get_gui_height();

x1Target = 0;
x2Target = display_get_gui_width();

animProgress = 0;
textProgress = 0;

msg = "weshe";
length = string_length(msg);
background = 0;




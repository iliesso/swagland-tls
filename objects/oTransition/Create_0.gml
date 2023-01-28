/// @description Size and mode setup

w = display_get_gui_width();
h = display_get_gui_height();
h_half = h/2;
tranHeight = 1.08;

//SlideTransition
enum TRANS_MODE     //Enumeration pour résumer les étapes du processus de transition (transition mode)
{
	OFF,
	NEXT,
	GOTO,
	RESTART,
	INTRO
}

mode = TRANS_MODE.INTRO; 
percent = 0.6;          //transition speed
target = room;        //where we wanna go during transition

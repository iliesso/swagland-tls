/// @description Roll the transition

//SlideTransition
if (mode != TRANS_MODE.OFF)
{
	if (mode == TRANS_MODE.INTRO)  //during intro
	{
		percent = max(0,percent - max((percent/10),0.005));
		
	}
	else			//other trans mode than intro
	{
		percent = min(tranHeight,percent + max(((tranHeight-percent)/10),0.005));
	}
	
	if (percent ==tranHeight) || (percent == 0)
	{
		switch(mode)
		{
			case TRANS_MODE.INTRO:
			{
				mode = TRANS_MODE.OFF; //if still intro mode: stop transition
				break;   
			}
			
			case TRANS_MODE.NEXT:
			{
				mode = TRANS_MODE.INTRO;
				room_goto_next();
				break;
			}
			case TRANS_MODE.GOTO:
			{
				mode = TRANS_MODE.INTRO;
				room_goto(target_room);
				break;
			}
			case TRANS_MODE.RESTART:
			{
				game_restart();
				break;
			}
		}
	}
}

///@desc SlideTransition(mode, targetroom)
///@arg mode: sets transition mode (TRANS_MODE)
///@arg targetroom: target room when using goto mode


function SlideTransition(){
	with (oTransition){
		mode = argument[0];
		if (argument_count > 1) target = argument[1];
	}
}
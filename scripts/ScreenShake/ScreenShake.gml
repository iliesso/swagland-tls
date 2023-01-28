/// @desc ScreenShake(magnitude, frames)
/// @arg magnitude: sets shake radius/length
/// @arg frames: sets the frame length (60 frames generally = 1 second)

function ScreenShake(magnitude, frames)
{
	with(oCamera)
	{
		if(argument0 > shake_remain)
		{
			shake_magnitude = argument0;
			shake_remain = shake_magnitude;
			shake_length= argument1;
		}
	}
}
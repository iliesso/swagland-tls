/// @desc ScreenShake(magnitude, frames)
/// @arg magnitude: sets shake radius/length
/// @arg frames: sets the frame length (60 frames generally = 1 second)

function ScreenShake(magnitude, frames)
{
	with(oCamera)
	{
		if(magnitude > shake_remain)
		{
			shake_magnitude = magnitude;
			shake_remain = shake_magnitude;
			shake_length= frames;
		}
	}
}
/// @description enemy health (death if no hp)

if (hp <= 0)
{
	with(instance_create_layer(x,y,layer,oEnemyDead))
	{
		direction = other.hitfrom;        //Direction of dead enemy body = last shoot direction
		hsp = lengthdir_x(2,direction);   //body is thrown towards direction
		vsp = lengthdir_y(2,direction)-2;
		if (sign(hsp) != 0) image_xscale = sign(hsp);   //facing going direction.
	} 
	instance_destroy();
}
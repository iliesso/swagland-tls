/// @description shooting enemy

with (other)
{
	hp -= 1;
	flash = 3;
	hitfrom = other.direction;
}

instance_destroy();
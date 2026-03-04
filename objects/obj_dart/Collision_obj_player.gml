if other.i_frame <= 0 && !hurtenemy
{
	hurt_player(self)
	with other
	{
		blend = #a3ed99
		poison = 60
	}
	instance_destroy()
}
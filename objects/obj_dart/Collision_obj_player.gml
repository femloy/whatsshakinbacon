if other.i_frame <= 0 && !hurtenemy
{
	hurt_player(self)
	with other
	{
		FMODevent_oneshot("event:/Sfx/General/Enemy/Ant/poisonget", x, y)
		blend = #a3ed99
		poison = 60
	}
	instance_destroy()
}
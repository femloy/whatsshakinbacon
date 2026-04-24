if fadeIn
{
	heartScale = anim * 6
	anim += animSpeed
	anim = min(anim, 1.2)
	animSpeed += 0.002
	if anim >= 1.2
	{
		FMODevent_oneshot("event:/Sfx/UI/slideOpen")
		room_goto(obj_player.targetRoom)
		anim = 0
		animSpeed = 0
		heartScale = 0
		fadeIn = false
	}
}
else
{
	heartScale = anim * 6
	anim += animSpeed
	anim = min(anim, 1)
	animSpeed += 0.001
	if anim == 1
	{
		instance_destroy()
	}
}
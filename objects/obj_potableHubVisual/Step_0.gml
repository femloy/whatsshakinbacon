if state == states.normal
{
	if x == targetMove
		movePause = approach(movePause, 0, 1)
	if movePause == 0
	{
		movePause = irandom_range(100, 400)
		targetMove = xstart + irandom_range(range, -range)
	}
	if posPrev != x
	{
		sprite_index = spr_move
		posPrev = x
	}
	else {
		sprite_index = spr_idle
	}
	x = approach(x, targetMove, 5)
	if targetMove != x
		image_xscale = sign(targetMove - x)
	if obj_player.state == states.taunt
	{
		state = states.taunt
		sprite_index = spr_taunt
		image_index = irandom(image_number)
		image_speed = 0
	}
}
if state == states.taunt
{
	image_speed = 0
	if obj_player.state != states.taunt
	{
		sprite_index = spr_idle
		image_speed = 0.35
		image_index = 0
		state = states.normal
	}
	if !instance_exists(tauntInst)
		{
			tauntInst = instance_create(x, y, obj_taunteffect)
			tauntInst.sprite_index = spr_tinytaunteffect
			tauntInst.target = self
		}
}
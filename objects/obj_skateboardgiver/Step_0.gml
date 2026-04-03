var _transfoPass = [
	states.skateboard,
	states.skateboardintro,
	states.skateboardramp,
	states.skateboardmove
	]
if array_contains(_transfoPass, obj_player.state)
	canGive = false
else
{
	if canGive == false
	{
		canGive = true
		create_particleStatic(spr_genericpoofeffect, x, y, 1, -2)
	}
}
visible = canGive
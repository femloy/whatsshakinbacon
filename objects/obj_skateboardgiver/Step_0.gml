var _transfoPass = [
	states.skateboard,
	states.skateboardintro,
	states.skateboardramp,
	states.skateboardmove
	]
if array_contains(_transfoPass, obj_player.state)
	canGive = false
else
	canGive = true
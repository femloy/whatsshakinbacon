var _transfoPass = [
	states.gunkIntro,
	states.gunkMove,
	states.gunk
	]
if array_contains(_transfoPass, obj_player.state)
	canGive = false
else
	canGive = true
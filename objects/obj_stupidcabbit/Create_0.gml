transfoPass = []
array_push(transfoPass, states.snowball)
array_push(transfoPass, states.snowballjump)
array_push(transfoPass, states.snowballwall)
array_push(transfoPass, states.skateboard)
array_push(transfoPass, states.skateboardmove)
array_push(transfoPass, states.skateboardwall)
array_push(transfoPass, states.skateboardramp)
array_push(transfoPass, states.gunkMove)
array_push(transfoPass, states.gunk)
image_speed = 0.35

idlesnd = FMODcreate_event("event:/Sfx/General/Enemy/Cabbit/idle")
FMODSet3dPos(idlesnd, x, y)
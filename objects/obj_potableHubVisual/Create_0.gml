if place_meeting(x, y, obj_solid)
{
	while place_meeting(x, y, obj_solid)
	{
		y--
	}
}
potable = 0
level = "forest"
ini_open(global.saveFile)
var _hasToppin = ini_read_real(level, $"Toppin{potable + 1}", 0) != 0
ini_close()

if !_hasToppin
	instance_destroy()

potableSprites = []
array_push(potableSprites, {idle: spr_potablebean_idle, move: spr_potablebean_move, taunt: spr_potablebean_taunt})
array_push(potableSprites, {idle: spr_potablecup_idle, move: spr_potablecup_move, taunt: spr_potablecup_taunt})
array_push(potableSprites, {idle: spr_potablelime_idle, move: spr_potablelime_move, taunt: spr_potablelime_taunt})
array_push(potableSprites, {idle: spr_potablebag_idle, move: spr_potablebag_walk, taunt: spr_potablebag_taunt})
array_push(potableSprites, {idle: spr_potableorange_idle, move: spr_potableorange_move, taunt: spr_potableorange_taunt})
state = states.normal
spr_idle = potableSprites[potable].idle
spr_move = potableSprites[potable].move
spr_taunt = potableSprites[potable].taunt

range = 200
movePause = irandom_range(60, 200)
x = xstart + irandom_range(range, -range)
targetMove = x
sprite_index = spr_idle
posPrev = x
image_speed = 0.35
depth = 15
tauntInst = -4
stickers = []
stickersAmt = 200
add_sticker = function(_x, _y) constructor 
{
	x = _x
	y = _y
	vspeed = 0
	targetSpeed = irandom_range(-5, -15)
	fadeSpeed = random_range((1 / 40), (1 / 70))
	index = irandom_range(0, sprite_get_number(spr_secret_transition_balloons))
	alpha = 1
	scale = 1.1
}
alarm[0] = 5
depth = -100
backAlpha = 0
goaway = false

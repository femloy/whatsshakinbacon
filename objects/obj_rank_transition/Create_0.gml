stickers = []
stickersAmt = 150
blend = c_lime
add_sticker = function(_x, _y) constructor 
{
	x = _x
	y = _y
	index = irandom_range(0, sprite_get_number(spr_rank_transition_stickers))
	scale = 1.3
	FMODevent_oneshot("event:/Sfx/General/Collects/collect", SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
}
alarm[0] = 5
depth = -100
backAlpha = 0


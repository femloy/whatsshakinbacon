if stickersAmt <= 0
{
	alarm[1] = 60
	exit;
}

alarm[0] = 1
var _x = irandom_range(-32, SCREEN_WIDTH + 32)
var _y = irandom_range(-32, SCREEN_HEIGHT + 32)
array_push(stickers, new add_sticker(_x, _y))
backAlpha += 1 / 150
stickersAmt--
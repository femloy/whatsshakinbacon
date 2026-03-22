if stickersAmt <= 0
{
	alarm[1] = 5
	exit;
}

alarm[0] = 1
repeat(5)
{
var _x = irandom_range(-32, SCREEN_WIDTH + 32)
var _y = irandom_range(-32, SCREEN_HEIGHT + 32)
array_push(stickers, new add_sticker(_x, _y))
}
backAlpha += 1 / (200 / 5)
stickersAmt -= 5
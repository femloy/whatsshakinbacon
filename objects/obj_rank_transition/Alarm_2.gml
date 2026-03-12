alarm[2] = 1
array_delete(stickers, 0, 1)
backAlpha -= 1 / 150
if array_length(stickers) <= 0
	instance_destroy()
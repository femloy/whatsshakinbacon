generalReset()

with obj_music
	stop_music()
	
with obj_player
{
	state = -4
	x = SCREEN_WIDTH / 2
	y = SCREEN_HEIGHT / 2
	sprite_index = sprites.gateslam
	image_index = 0
	image_speed = 0.35
}

y = SCREEN_HEIGHT / 2
x = -(SCREEN_WIDTH / 2)
vsp = 0
whiteAlpha = 0
x = SCREEN_WIDTH / 2
y = -200
FMODevent_oneshot("event:/Music/General/timesup", x, y)
alarm[0] = 60 * 2.9
alarm[1] = 60 * 6
vsp = 0
falling = false
depth = 15
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
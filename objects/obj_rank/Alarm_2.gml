if toppinPos < array_length(toppins)
{
	toppins[toppinPos][0] = true
	toppinPos++
	alarm[2] = 10
	FMODevent_oneshot("event:/Sfx/Player/minijohnpunch", SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
}
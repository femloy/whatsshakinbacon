if global.has_paint
{
	if active
		exit;
	active = true
	alarm[0] = 5
	image_blend = c_white
	FMODevent_oneshot("event:/Sfx/General/Level/Shell City/spray", x, y)
	FMODevent_oneshot("event:/Sfx/General/Collects/bigcollect", x, y)
	global.combo.timer = 60
	global.painting_count++
}
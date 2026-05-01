image_speed = 0.35
event_inherited();
if og_x != x || og_y != y
{
	sprite_index = spr_walk
	og_x = x
	og_y = y
}
else 
{
	sprite_index = spr_idle
}
if global.painting_count >= global.painting_max
{
	instance_destroy()
	global.can_enter_bus = true
	FMODevent_oneshot("event:/Sfx/General/Level/Shell City/busNotif")
}
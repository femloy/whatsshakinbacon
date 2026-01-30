if sprite_index == spr_checkpoint
{
	image_index = 0
	sprite_index = spr_checkpoint_activating
	other.roomstartX = x
	other.roomstartY = y
	FMODevent_oneshot("event:/Sfx/General/checkpoint", x, y)
}
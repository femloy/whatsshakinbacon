depth = 10
cutscene = false
image_speed = 0.35
facing = sign(image_xscale)
image_index = 0
if obj_player.door == "DOODLE"
{
	obj_player.x = x
	obj_player.y = y
	obj_player.sprite_index = spr_player_groundpound
	cutscene = true
	sprite_index = spr_loveportal_open_broken
	image_index = 0
	FMODevent_oneshot("event:/Sfx/General/Level/Progression/exitpage", x, y)
}
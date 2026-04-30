// Inherit the parent event
event_inherited();
tv_anim(spr_tv_happy, 60 * 3)
global.combo.timer = 60
with obj_player
{
	if chance(1 / 4)
		fmod_studio_event_instance_start(soundsLaugh)
}

spr_idle = Sprite667
spr_walk = spr_player_move
sprite_index = spr_idle
image_index = 0
og_x = x
og_y = y
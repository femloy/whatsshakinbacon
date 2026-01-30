// Inherit the parent event
event_inherited();
tv_anim(spr_tv_happy, 60 * 3)
global.combo.timer = 60
with obj_player
{
	if chance(1 / 4)
		fmod_studio_event_instance_start(soundsLaugh)
}

spr_idle = spr_detective_idle
spr_walk = spr_detective_move
spr_panicidle = spr_detective_idle
spr_intro = spr_detective_intro
spr_taunt = spr_detective_taunt

sprite_index = spr_intro
image_index = 0
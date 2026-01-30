// Inherit the parent event
event_inherited();
global.collect += 1000
global.combo.timer = 60
global.toppins.bag = true
create_smalltext(1000)
FMODevent_oneshot("event:/Sfx/General/Collects/toppinget", x, y)
tv_anim(spr_tv_happy, 60 * 3)
with obj_player
{
	if chance(1 / 4)
		fmod_studio_event_instance_start(soundsLaugh)
}
spr_idle = spr_potablebag_idle
spr_walk = spr_potablebag_walk
spr_panicidle = spr_potablebag_idle
spr_intro = spr_potablebag_intro
spr_taunt = spr_potablebag_taunt

if obj_player.character == characters.milton
{
	spr_idle = spr_miltoppin_idle
	spr_walk = spr_miltoppin_idle
	spr_panicidle = spr_miltoppin_idlepanic
	spr_intro = spr_potablebean_intro
	spr_taunt = spr_miltoppin_idle
}

sprite_index = spr_intro
image_index = 0
// Inherit the parent event
event_inherited();
global.collect += 1000
global.combo.timer = 60
global.toppins.lime = true
create_smalltext(1000)
FMODevent_oneshot("event:/Sfx/General/Collects/toppinget", x, y)
tv_anim(spr_tv_happy, 60 * 3)
with obj_player
{
	if chance(1 / 4)
		fmod_studio_event_instance_start(soundsLaugh)
}
spr_idle = spr_potablelime_idle
spr_walk = spr_potablelime_move
spr_panicidle = spr_potablelime_idlepanic
spr_intro = spr_potablelime_intro
spr_taunt = spr_potablelime_taunt

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
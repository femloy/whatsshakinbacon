var __val = super ? 200 : 100
global.collect += __val
global.combo.timer = 60
create_smalltext(__val)
create_collect(sprite_index, x, y)
ds_list_add(global.saveroom, id)
instance_destroy()
FMODevent_oneshot("event:/Sfx/General/Collects/bigcollect", x, y)
tv_anim(spr_tv_happy, 60 * 3)
with obj_player
{
	if irandom(100) <= 25
		fmod_studio_event_instance_start(soundsLaugh)
}
repeat(4)
	create_particleStatic(spr_sparkle, x + irandom_range(-16, 16), y + irandom_range(-16, 16), 1)
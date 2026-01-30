if !instance_exists(obj_option)
getMenu_input()

var _nopauseRooms = 
room == rm_intro ||
room == timesup_room ||
room == Mainmenu||
instance_exists(obj_fadeout)||
instance_exists(obj_rank)||
instance_exists(obj_technicaldifficulty)||
instance_exists(obj_titlecard)||
obj_shell.isOpen
if !active
{
	graphBack.alpha = approach(graphBack.alpha, 0, 0.1)
}
if !active && key_start2 && !_nopauseRooms
{ 
	doPause()
}
else if active && !instance_exists(obj_option) && buffer == 0
{
	graphBack.alpha = approach(graphBack.alpha, 0.4, 0.01)
	var move = key_down2 - key_up2
	if move != 0
	{
		selected += move
		FMODevent_oneshot("event:/Sfx/UI/Pause/step")
	}
	selected = clamp(selected, 0, array_length(options) - 1)
	if key_slap2 || key_start2
		doUnpause()
	if key_jump2
		options[selected].func()
	var _pos = fmod_studio_event_instance_get_timeline_position(pauseMusic) * 0.01
}
buffer = approach(buffer, 0, 1)

fmod_studio_system_set_parameter_by_name("SfxVolume", global.SfxVolume, true)
fmod_studio_system_set_parameter_by_name("AmbianceVolume", global.AmbianceVolume, true)
if instance_exists(obj_monolith) && !obj_pause.active
	fmod_studio_system_set_parameter_by_name("MusicVolume", global.MusicVolume * 1 - obj_music.pillar, true)
else
	fmod_studio_system_set_parameter_by_name("MusicVolume", global.MusicVolume, true)
fmod_studio_system_set_parameter_by_name("MasterVolume", global.MasterVolume, true)
fmod_studio_system_set_parameter_by_name("unfocusMute", !window_has_focus() && global.unfocus_mute, false)

for (var i = 0; i < array_length(backgroundhearts); i++) 
{
	var q = backgroundhearts[i]
	q.y -= 0.5
	q.image_index += q.image_speed
	var _delete = q.y < SCREEN_HEIGHT / 2 - 32
	if _delete
		q.image_alpha -= 0.01
	else {
		q.image_alpha = approach(q.image_alpha, 1, 0.05)
	}
	if !active
	{
		_delete = true
		q.image_alpha -= 0.1
	}
	if _delete && q.image_alpha <= 0
	{
		q = undefined
		array_delete(backgroundhearts, i, 1)
		i--
	}
}
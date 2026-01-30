global.Fmod3dDefaults =
{
	position: { x: 0, y: 0, z: 0 },
	velocity: { x: 0, y: 0, z: 0 },
	forward: { x: 0, y: 0, z: 1 },
	up: { x: 0, y: 1, z: 0 },
}

global.FMOD_existingEvents = []

function FMODcreate_event(_path)
{
	var _desc = fmod_studio_system_get_event(_path)
	var _inst = fmod_studio_event_description_create_instance(_desc)
	array_push(global.FMOD_existingEvents, _inst)
	return _inst
}

function FMODget_eventLength(_path)
{
	var _desc = fmod_studio_system_get_event(_path)
	return fmod_studio_event_description_get_length(_desc)
}

function FMODevent_oneshot(_snd, _x, _y)
{
	var _inst = FMODcreate_event(_snd)
	fmod_studio_event_instance_start(_inst);
	if !is_undefined(_x) && !is_undefined(_y)
		FMODSet3dPos(_inst, _x, _y)
	fmod_studio_event_instance_release(_inst);
	return _inst
}

function FMODSet3dPos(_event, _x, _y)
{
	var _att = global.Fmod3dDefaults
	_att.position = { x: _x, y: _y, z: 0 }
	fmod_studio_event_instance_set_3d_attributes(_event, _att)
}

function FMODsetPauseAll(_pause)
{
	for (var i = 0; i < array_length(global.FMOD_existingEvents); i++)
	{
		if fmod_studio_event_instance_is_valid(global.FMOD_existingEvents[i])
			fmod_studio_event_instance_set_paused(global.FMOD_existingEvents[i], _pause)
	}
}

function FMODstopAll()
{
	for (var i = 0; i < array_length(global.FMOD_existingEvents); i++)
	{
		if fmod_studio_event_instance_is_valid(global.FMOD_existingEvents[i])
			fmod_studio_event_instance_stop(global.FMOD_existingEvents[i], FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT)
	}
}

function FMODevent_isplaying(_event)
{
	return fmod_studio_event_instance_get_playback_state(_event) == FMOD_STUDIO_PLAYBACK_STATE.PLAYING
}

function FMODevent_isstarting(_event)
{
	return fmod_studio_event_instance_get_playback_state(_event) == FMOD_STUDIO_PLAYBACK_STATE.STARTING
}

function FMODget_path(_event)
{
	var _des = fmod_studio_event_instance_get_description(_event)
	return fmod_studio_event_description_get_path(_des);
}






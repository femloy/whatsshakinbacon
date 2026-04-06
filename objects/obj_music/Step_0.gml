if func != -4
	func()


if global.escape.active == false {
	panicStart = true
	if FMODevent_isplaying(escapeInst)
		fmod_studio_event_instance_stop(escapeInst, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT)
}
else {
	if panicStart == true{
		panicStart = false
		if !FMODevent_isplaying(escapeInst)
			fmod_studio_event_instance_start(escapeInst)
	}
	else {
		if fmod_studio_event_instance_get_paused(musicInst) == false
			fmod_studio_event_instance_set_paused(musicInst, true)
		var _final = global.level == "hotel"
		if _final
		{
			fmod_studio_event_instance_set_parameter_by_name(escapeInst, "state", 3)
		}
		else
		{
			if global.escape.party
			{
				fmod_studio_event_instance_set_callback(escapeInst, FMOD_STUDIO_EVENT_CALLBACK.TIMELINE_BEAT)
				fmod_studio_event_instance_set_parameter_by_name(escapeInst, "state", 2)
				fmod_studio_event_instance_set_callback(escapeInst, FMOD_STUDIO_EVENT_CALLBACK.TIMELINE_BEAT)
			
			}
			else
			{
				if global.escape.timer < (60 * 50) // 50 seconds, pinch time
					fmod_studio_event_instance_set_parameter_by_name(escapeInst, "state", 1)
				else
					fmod_studio_event_instance_set_parameter_by_name(escapeInst, "state", 0)
			}
		}
	}
}

if instance_exists(obj_monolith){
	if !FMODevent_isplaying(monolith) && !FMODevent_isstarting(monolith)
		fmod_studio_event_instance_start(monolith)
	fmod_studio_event_instance_set_paused(monolith, false)
	with obj_monolith
		var _cam = in_camera()
	pillar = approach(pillar, _cam, 1 / 60)
}
else {
	if FMODevent_isplaying(monolith)
		fmod_studio_event_instance_stop(monolith, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT)
	pillar = 0
}
fmod_studio_event_instance_set_parameter_by_name(monolith, "flitzani", pillar, true)

var roomname = string_letters(room_get_name(room))
var _isSecret = string_pos("secret", roomname) > 0 || room == hotel_soundtest
if isSecret != _isSecret
{
	isSecret = _isSecret
	if isSecret
	{
		var _timelineMusic = fmod_studio_event_instance_get_timeline_position(musicInst)
		var _length = _timelineMusic / FMODget_eventLength(music.regular)
		var _pos = _length * FMODget_eventLength(music.secret)
		fmod_studio_event_instance_set_timeline_position(secretInst, _pos)
	}
}
//
var q = 0
if musicInst != -4
	q = fmod_studio_event_instance_get_timeline_position(musicInst)
if isSecret && secretInst != -4
    q = fmod_studio_event_instance_get_timeline_position(secretInst)

//

var s = -4
if musicInst != -4
	s = FMODget_path(musicInst)
if isSecret && secretInst != -4
    s = FMODget_path(secretInst)
currentMusic = s
fmod_studio_event_instance_set_paused(escapeInst, isSecret)
if musicInst != -4
	fmod_studio_event_instance_set_paused(musicInst, isSecret || FMODevent_isplaying(escapeInst) || pauseMusic)
if ambienceInst != -4
	fmod_studio_event_instance_set_paused(ambienceInst, isSecret || FMODevent_isplaying(escapeInst) || pauseMusic)
if secretInst != -4
	fmod_studio_event_instance_set_paused(secretInst, !isSecret || pauseMusic)
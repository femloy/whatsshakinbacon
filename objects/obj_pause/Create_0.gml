depth = obj_screensizer.depth + 800
active = false
border_size = 2
backdrop = {alpha: 0, x: 0, y: 0}
screenSprite = -4
pauseMusic = FMODcreate_event("event:/Music/General/pause")
vinylSND = FMODcreate_event("event:/Sfx/vinyl")
selected = 0
options = []
buffer = 0
tipText = ""
heartFind = 1
isMilton = false
character = characters.mildred

alarm[0] = 60

addPause_icon = function(_index) constructor
{
	index = _index
	alpha = 0
}

function doPause()
{
	fmod_studio_event_instance_set_parameter_by_name(pauseMusic, "state", obj_player.character == characters.milton)
	playeractiveState = obj_player.state
	character = obj_player.character
	isMilton = obj_player.character == characters.milton
	active = true
	for (var i = 0; i < array_length(secrets); i++)
	{
		var q = secrets[i]
		q.secret = false
	}
	FMODsetPauseAll(true)
	if sprite_exists(screenSprite)
		sprite_delete(screenSprite)
	screenSprite = sprite_create_from_surface(obj_screensizer.gameSurface, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, false, false, 0, 0)
	instance_deactivate_all(true)
	instance_activate_object(obj_inputController)
	instance_activate_object(obj_screensizer)
	instance_activate_object(obj_fmod)
	instance_activate_object(obj_shell)
	instance_activate_object(obj_rpc)
	instance_activate_object(obj_globaltimer)
	instance_activate_object(obj_savesystem)
	fmod_studio_event_instance_start(pauseMusic)
	fmod_studio_event_instance_set_paused(pauseMusic, false)
	
	fmod_studio_event_instance_start(vinylSND)
	fmod_studio_event_instance_set_paused(vinylSND, false)
	fmod_studio_system_set_parameter_by_name("musicfade", 0, false)
	FMODevent_oneshot("event:/Sfx/General/Cutscene/recordstop")
	backdrop.alpha = 0
	selected = 0
	switch playeractiveState
	{
		case states.ski:
			tipText = lang_get_phrase("tip_ski")
			break
		case states.surfing:
			tipText = lang_get_phrase("tip_surf")
			break
		default:
			tipText = ""
			break
	}
	
	options = []
	var _resume =
	{ option: "pause_resume", event: 5 }
	var _restart =
	{ option: "pause_restart", event: 1 }
	var _option =
	{ option: "pause_options", event: 4 }
	var _tasks =
	{ option: "pause_tasks", event: 3 }
	var _exitlevel =
	{ option: global.level == noone ? "pause_menu" : "pause_exit", event: 2 }
	_resume.offsetX = -SCREEN_WIDTH
	_option.offsetX = -SCREEN_WIDTH
	_restart.offsetX = -SCREEN_WIDTH
	_tasks.offsetX = -SCREEN_WIDTH
	_exitlevel.offsetX = -SCREEN_WIDTH

	_resume.icon = new addPause_icon(0)
	_option.icon = new addPause_icon(1)
	_restart.icon = new addPause_icon(2)
	_tasks.icon = new addPause_icon(8)
	_exitlevel.icon = new addPause_icon(3)
	array_push(options, _resume)
	array_push(options, _option)
	if global.level != noone
		array_push(options, _restart)
	if global.level != noone && global.level != "tutorial"
		array_push(options, _tasks)
	array_push(options, _exitlevel)
}

function doUnpause()
{
	instance_activate_all()
	FMODsetPauseAll(false)
	fmod_studio_event_instance_stop(pauseMusic, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT)
	fmod_studio_event_instance_stop(vinylSND, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT)
	with obj_music
	{
		fmod_studio_event_instance_set_paused(escapeInst, isSecret)
		fmod_studio_event_instance_set_paused(musicInst, isSecret || FMODevent_isplaying(escapeInst))
		fmod_studio_event_instance_set_paused(secretInst, !isSecret)
	}
	active = false
}

var _resume =
{ option: "pause_resume", event: 5 }
var _restart =
{ option: "pause_restart", event: 1 }
var _option =
{ option: "pause_options", event: 4 }
var _tasks =
{ option: "pause_tasks", event: 3 }
var _exitlevel =
{ option: "pause_exit", event: 2 }
_resume.offsetX = -SCREEN_WIDTH
_option.offsetX = -SCREEN_WIDTH
_restart.offsetX = -SCREEN_WIDTH
_tasks.offsetX = -SCREEN_WIDTH
_exitlevel.offsetX = -SCREEN_WIDTH

_resume.icon = new addPause_icon(0)
_option.icon = new addPause_icon(1)
_restart.icon = new addPause_icon(2)
_tasks.icon = new addPause_icon(8)
_exitlevel.icon = new addPause_icon(3)
array_push(options, _resume)
array_push(options, _option)
array_push(options, _restart)
array_push(options, _tasks)
array_push(options, _exitlevel)

timeUniform = shader_get_uniform(shd_wave, "time");
frequencyUniform = shader_get_uniform(shd_wave, "frequency");
amplitudeUniform = shader_get_uniform(shd_wave, "amplitude");
waveTime = 0
freq = 0.01
amp = 0.009

secrets = []
array_push(secrets, {x: 42, y: 114, index: 0, secret: false, scale: 1})
array_push(secrets, {x: 43, y: 43, index: 1, secret: false, scale: 1})
array_push(secrets, {x: 95, y: 72, index: 2, secret: false, scale: 1})

backgroundhearts = []
create_background_heart = function(_x, _y)
{
	var q = 
	{
		x: _x,
		y: _y,
		sprite_index: spr_pause_heart_fly,
		image_index: 0,
		image_speed: 0.04,
		image_alpha: 0,
	}
	if active
		array_push(backgroundhearts, q)
	return q
}
treasureAlpha = 0
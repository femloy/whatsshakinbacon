depth = obj_screensizer.depth + 200
active = false
graphBorderSize = 2
graphBack = {alpha: 0, x: 0, y: 0}
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
	graphBack.alpha = 0
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
{ option: "pause_resume", func: function() { 
with obj_pause
{
	doUnpause()
} } }
var _restart =
{ option: "pause_restart", func: function() {
with obj_pause
{
	if global.resetRoom != noone
	{
		if instance_exists(obj_rank_transition)
			instance_destroy(obj_rank_transition)
		if instance_exists(obj_secret_transition)
			instance_destroy(obj_secret_transition)
		if instance_exists(obj_backtohub)
			instance_destroy(obj_backtohub)
		doUnpause()
		FMODstopAll()
		with obj_music
		{
			stop_music()
			if FMODevent_isplaying(escapeInst)
				fmod_studio_event_instance_stop(escapeInst, FMOD_STUDIO_STOP_MODE.IMMEDIATE)
		}
		with obj_player
		{
			generalReset()
			door = "A"
			movespeed = 0
			vsp = 0
			hsp = 0
			state = states.enterdoor
		}
		room_goto(global.resetRoom)
	}

}
} }
var _option =
{ option: "pause_options", func: function() { 
	FMODevent_oneshot("event:/Sfx/UI/Pause/menuselect")
	instance_create(0, 0, obj_option)
	} }
var _tasks =
{ option: "pause_tasks", func: function() { 
	FMODevent_oneshot("event:/Sfx/UI/Pause/menuselect")
	instance_create(0, 0, obj_feats)
	} }
var _exitlevel =
{ option: "pause_exit", func: function() 
{
	with obj_pause
	{
		doUnpause()
		FMODstopAll()
		if instance_exists(obj_backtohub)
			instance_destroy(obj_backtohub)
		if instance_exists(obj_rank_transition)
			instance_destroy(obj_rank_transition)
		if instance_exists(obj_secret_transition)
			instance_destroy(obj_secret_transition)
		with obj_player
		{
			if global.level == noone
			{
				with obj_music
					stop_music()
				generalReset()
				movespeed = 0
				vsp = 0
				hsp = 0
				state = -4
				door = "A"
				room_goto(Mainmenu)
			}
			else 
			{
				with obj_music
					stop_music()
				generalReset()
				movespeed = 0
				vsp = 0
				hsp = 0
				state = -4
				door = "NONE"
				room_goto(backtohubRoom)
				instance_create(x, y, obj_backtohub)
				global.level = noone
				global.resetRoom = noone
			}
		}
	}
} }
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
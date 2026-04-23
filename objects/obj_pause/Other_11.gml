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
if state == states.crouch && sprite_index == spr_egghead_charge
	{
		fmod_studio_event_instance_set_paused(chargeSnd, false);
		if !FMODevent_isplaying(chargeSnd)
			fmod_studio_event_instance_start(chargeSnd);
		FMODSet3dPos(chargeSnd, x, y); 
	}
	else{
		fmod_studio_event_instance_stop(chargeSnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
	}
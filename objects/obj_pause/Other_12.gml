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
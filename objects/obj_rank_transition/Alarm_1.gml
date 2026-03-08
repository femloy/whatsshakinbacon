with obj_player
		{
			generalReset()
			movespeed = 0
			vsp = 0
			hsp = 0
			state = states.enterdoor
			door = "BACKTOHUB"
			visible = true
			room_goto(backtohubRoom)
			if instance_exists(obj_backtohub)
				instance_destroy(obj_backtohub)
		}
		global.level = noone
		global.resetRoom = noone
		instance_destroy(obj_rank)
alarm[2] = 1
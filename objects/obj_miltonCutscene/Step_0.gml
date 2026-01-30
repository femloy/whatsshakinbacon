switch scene
{
	case -1:
		with obj_player
		{
			state = -4
			if grounded
			{
				sprite_index = spr_player_hurt
				image_speed = 0.35
				xscale = 1
				movespeed = -2
				hsp = movespeed * xscale
				with obj_miltonHubNPC
				{
					image_xscale = -1
				}
				other.scene = 0
				other.alarm[1] = 60 * 1.5
			}
			else {
				image_speed = 0.35
				hsp = 0
				movespeed = 0
				sprite_index = spr_player_fall
			}
		}
		break
	case 3:
	case 0:
		with obj_player
		{
			state = -4
			hsp = movespeed * xscale
			movespeed = approach(movespeed, 0, 0.1)
		}
		break
	case 1:
		with obj_player
		{
			sprite_index = sprites.idle
			image_speed = 0.35
		}
		break
	case 2:
		instance_destroy(obj_miltonHubNPC)
		fmod_studio_event_instance_stop(songInst, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT)
		fmod_studio_event_instance_release(songInst)
		with obj_player
		{
			if grounded
			{
				sprite_index = spr_player_hurt
				image_speed = 0.35
				xscale = 1
				movespeed = -2
				hsp = movespeed * xscale
				other.scene = 3
				other.alarm[3] = 100
			}
		}
		break
}
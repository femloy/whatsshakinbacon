trigger = function() 
{
		if place_meeting(x, y, obj_player)
		{
			obj_player.vsp = -20
			obj_player.state = states.slip
			obj_player.sprite_index = spr_player_slipsyrup
			obj_player.image_index = 0
			obj_player.image_speed = 0.35
		}
		instance_destroy()
}
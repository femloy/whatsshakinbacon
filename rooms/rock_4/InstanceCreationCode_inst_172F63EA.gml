trigger = function() 
{
		if place_meeting(x, y, obj_player)
		{
			obj_player.vsp = lerp(obj_player.vsp, -15, 0.2)
			obj_player.state = states.jump
			obj_player.sprite_index = spr_player_spinout
			obj_player.image_speed = 0.35
		}
}
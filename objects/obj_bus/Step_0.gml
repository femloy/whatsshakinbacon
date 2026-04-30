var _near_player = point_distance(xstart, 0, obj_player.x, 0) <= 32 * 6
var _targetX = !_near_player ? xstart : obj_camera.camera.x + (obj_camera.camera.width) + sprite_width

if !global.can_enter_bus
{
	x = approach(x, _targetX, 32)
}
else
{
	with obj_player
	{
		if !place_meeting(x, y, other)
			exit;
		if grounded && key_up && state != states.enterdoor && state != states.walkfront
		{
			targetRoom = other.targetRoom
			door = other.targetDoor
			hallway = false
			movespeed = 0
			vsp = 0
			hsp = 0
			state = states.enterdoor
			sprite_index = spr_player_lookdoor
			image_index = 0
		}
	}
}
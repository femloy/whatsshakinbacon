with obj_player
{
	if place_meeting(x, y, other.objId) && state != states.enterdoor && state != states.walkfront
		other.active = true
	else
		other.active = false
}
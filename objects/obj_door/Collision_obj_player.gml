var _transfoPass = [
	states.snowball, 
	states.snowballjump, 
	states.snowballwall, 
	states.skateboard, 
	states.skateboardaim, 
	states.skateboardhitwall, 
	states.skateboardramp, 
	states.skateboardwall, 
	states.skateboardmove, 
	states.coconutgun, 
	states.coconutshoot,
	states.coconutjump]
if array_contains(_transfoPass, other.state)
	exit;
if blocked
	exit;
if other.grounded && other.key_up && other.state != states.enterdoor && other.state != states.walkfront && other.state != states.snowball
{
	with other
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
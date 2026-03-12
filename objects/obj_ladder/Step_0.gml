with (instance_place(x, y - 1, obj_player))
{
	var _ladderState = [states.normal, states.jump, states.crouch, states.uppercut, states.mach2, states.mach3]
	if !array_contains(_ladderState, state)
		exit;
	if key_up && place_meeting(x, y, obj_ladder) && !key_down && state != states.crouch || (key_down && grounded && place_meeting(x, y + 1, obj_ladder) && !place_meeting(x, y + 1, obj_solid) && !key_up)
	{
		state = states.ladder
		hsp = 0
		movespeed = 0
		if key_down && grounded && !key_up
			y = other.y + 1
	}
}
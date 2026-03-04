function scr_collide_destructibles()
{
	var _list = ds_list_create()
	var _destroy = false
	var _num = instance_place_list(x + hsp + xscale, y + vsp, obj_destructibles, _list, false);

	if _num > 0 
	{
		for (var i = 0; i < _num; i++;)
	    {
			var _obj = _list[| i]
			
			var _horizontal =
				state == states.mach2 ||
				state == states.mach3 ||
				state == states.grab ||
				state == states.tumble ||
				state == states.hammerattack ||
				state == states.buzzsaw || 
				sprite_index == spr_player_swingading
			
			var _vertical =
				state == states.groundpound ||
				state == states.uppercut ||
				state == states.superjump ||
				state == states.buzzsaw ||
				state == states.climbwall ||
				(state == states.jump && vsp < 0)
			
			if _horizontal && place_meeting(x + (hsp + xscale) * 2, y, _obj)
				_destroy = true
			if _vertical && place_meeting(x, y + (vsp * 2) + 1, _obj)
				_destroy = true
			
			if _destroy
	        	instance_destroy(_obj);
	    }
	}
	
	ds_list_destroy(_list)
}
function scr_collide_destructibles()
{
	var _list = ds_list_create()
	var _horizontal =
	state == states.machslide ||
	state == states.machturn ||
	state == states.mach2 ||
	state == states.mach3 ||
	state == states.grab ||
	state == states.uppercut ||
	state == states.tumble ||
	state == states.hammerattack ||
	state == states.buzzsaw || 
	sprite_index == spr_player_swingading
			
	var _vertical =
	state == states.machturn ||
	state == states.groundpound ||
	state == states.groundpoundstart ||
	state == states.uppercut ||
	state == states.superjump ||
	state == states.buzzsaw ||
	state == states.climbwall || 
	(state == states.jump && vsp < 0)
	var _x = x
	var _y = y
	if _horizontal
		_x = x + (hsp + xscale) * 2
	if _vertical
		_y = y + (vsp * 2) + 1
	var _num = instance_place_list(_x, _y, obj_destructibles, _list, false);
	if _num > 0 
	{
		for (var i = 0; i < _num; i++;)
	    {
			var _obj = _list[| i]
	  		instance_destroy(_obj);
	    }
	}
	
	ds_list_destroy(_list)
}
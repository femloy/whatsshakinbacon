function scr_collision_init()
{
	vsp = 0;
	hsp = 0;
	grav = 0;
	grounded = false;
	coyote_time = 0;
	can_coyote = true;
}

function scr_collision()
{
	grounded = false
	var o_x = x, o_y = y, __hspPlat = 0, __vspPlat = 0
	if vsp < 20
		vsp += !place_meeting(x, y, obj_water) ? grav : grav / 2
	var finalHsp = hsp
	var finalVsp = vsp
	
	repeat round(abs(finalVsp))
	{
		o_y = y
		if abs(finalVsp) != 0
			y += sign(finalVsp);
		else
			y += finalVsp;
		if scr_solid(x, y)
		{
			y = o_y
			vsp = 0
			finalVsp = 0
		}
	}
	
	repeat round(abs(finalHsp))
	{
		o_x = x
		if abs(finalHsp) != 0
			x += sign(finalHsp);
		else
			x += finalHsp;
		var inc = 8
		if vsp >= -1
		{
			for (var i = 0; i < inc; i++)
			{
					if !scr_solid(x, y - i) // up slopes
					{
						while scr_solid(x, y)
							y--
					}
					if scr_solid(x, y + i + 1) && scr_solid(x - sign(finalHsp), y + i) // down slopes
					{
						while !scr_solid(x, y + 1)
							y++
					}
			}
		}
		
		if scr_solid(x, y)
		{
			x = o_x
			hsp = 0
			finalHsp = 0
		}
	}
	
	grounded |= scr_solid(x, y + 1)
}

function scr_slope(_x, _y)
{
	var _collided = false
	with (instance_place(_x, _y, obj_slope))
		_collided = scr_slope_collideCheck(other.id, _x, _y)
	return _collided
}

function scr_solid(_x, _y)
{
	var _collided = false
	var _id = id
	var _collisionArray = []
	array_push(_collisionArray, obj_solid)
	array_push(_collisionArray, obj_slope)
	array_push(_collisionArray, obj_platform)
	array_push(_collisionArray, obj_destructibles)
	for (var i = 0; i < array_length(_collisionArray); i++)
	{
		var _obj = _collisionArray[i]
		var _parentCheck = false
			with instance_place(_x, _y, _obj)
			{
				switch object_index
				{
					case obj_solid: 
						_collided = true
						break
					case obj_slope:
						_collided = scr_slope_collideCheck(_id, _x, _y)
						break
					case obj_platform: 
						if _id.bbox_bottom - 1 <= bbox_top + 1 && _id.vsp >= 0 
							_collided = true 
					break
				default:
					_parentCheck = true
					break
				}
			if _parentCheck
			{
					switch object_get_parent(object_index)
					{
					case obj_destructibles: 
					case obj_solid: 
						_collided = true
						break
					case obj_slope:
						_collided = scr_slope_collideCheck(_id, _x, _y)
						break
					case obj_platform: 
						if _id.bbox_bottom - 1 <= bbox_top + 1 && _id.vsp >= 0 
							_collided = true 
						break
					}
			}
			}
	}
	return _collided
}


function scr_slope_collideCheck(_playerId, _x, _y)
{
	var _height = _playerId.bbox_bottom - _playerId.y
	var _slope = (bbox_bottom - bbox_top) / (bbox_right - bbox_left)
	var _side = _x + (_playerId.bbox_left - _playerId.x)
	var _slopeFinal = bbox_bottom + ((_side - bbox_right) * _slope)
	if (image_xscale > 0)
	{
		_side = _x + (_playerId.bbox_right - _playerId.x)
		_slopeFinal = bbox_bottom - ((_side - bbox_left) * _slope)
	}
	if image_yscale < 0
	{
		_height = _playerId.y - _playerId.bbox_top
		return _y + _height < bbox_top + (bbox_bottom - _slopeFinal);
	}
	return _y + _height > _slopeFinal;
}

function scr_slope_get(_x = 0, _y = 1)
{
	return instance_place(x + _x, y + _y, obj_slope);
}

function place_meeting_solid(_x = 0, _y = 1)
{
	return place_meeting(x + _x, y + _y, obj_solid);
}

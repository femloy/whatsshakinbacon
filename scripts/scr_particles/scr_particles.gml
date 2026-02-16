function create_particleStatic(_sprite, _x, _y, _xscale, _depth = 1)
{
	var par =
	{
		type: 0,
		sprite_index: _sprite,
		image_index: 0,
		image_angle: 0,
		x: _x,
		y: _y,
		image_xscale: _xscale,
		depth: _depth,
		hsp: 0,
		vsp: 0,
		grav: 0,
		image_speed: 0.35,
	}
	ds_list_add(obj_particleSystem.particles, par)
	return par;
}

function create_particleDebri(_sprite, _index, _x, _y, _xscale, _depth = 1, _angle = random_range(0, 360), _vsp = random_range(-5, 5), _hsp = random_range(5, -5))
{
	var par = create_particleStatic(_sprite, _x, _y, _xscale, _depth)
	with par
	{
		hsp = _hsp
		vsp = _vsp
		grav = 0.4
		image_index = _index
		image_angle = _angle
		image_speed = 0
	}
	return par;
}

function create_collect(_sprite, _x, _y, _bypass = false)
{
	if _bypass == false
	{
		_x -= camera_get_view_x(view_camera[0])
		_y -= camera_get_view_y(view_camera[0])
	}
	var par =
	{
		sprite_index: _sprite,
		x: _x,
		y: _y,
		hsp: 0,
		vsp: 0,
		Hmvsp: 0,
		Vmvsp: 0,
		movespeed: 12
	}
	ds_list_add(obj_hud.collectVis, par)
	return par;
}

function create_afterimage(_sprite, _index, _x, _y, _xscale, _alpha = 1)
{
	var aft =
	{
		sprite_index: _sprite,
		image_index: _index,
		x: _x,
		y: _y,
		image_xscale: _xscale,
		image_blend: choose(#e48397, #b51a3a),
		alarm: [15],
		type: afterimagetype.normal,
		alpha: _alpha,
		fadeoutAlpha: 1,
		fadeout: false,
		image_alpha: 1,
		visible: true,
	}
	ds_list_add(obj_afterimageSystem.afterimages, aft)
	return aft;
}

function create_buzzsawAfterimage(_sprite, _index, _x, _y, _xscale, _alpha = 0.8)
{
	var q = create_afterimage(_sprite, _index, _x, _y, _xscale, _alpha)
	q.image_blend = c_white
	q.type = afterimagetype.buzzsaw
	return q
}

function create_machEffect(_sprite, _index, _x, _y, _xscale, _alpha = 0.8)
{
	var q = create_afterimage(_sprite, _index, _x, _y, _xscale, _alpha)
	q.type = afterimagetype.mach
	return q
}

function create_miltonAfterimage(_sprite, _index, _x, _y, _xscale, _alpha = 0.8)
{
	var q = create_afterimage(_sprite, _index, _x, _y, _xscale, _alpha)
	q.image_blend = c_white
	q.type = afterimagetype.milton
	return q
}

function create_selectcolorAfterimage(_sprite, _index, _x, _y, _xscale, _alpha = 0.8, selectcolor = #ffffff, selectcolor2 = #000000)
{
	var q = create_afterimage(_sprite, _index, _x, _y, _xscale, _alpha)
	q.image_blend = c_white
	q.type = afterimagetype.selectcolor
	q.selectcolor = selectcolor
	q.selectcolor2 = selectcolor2
	return q
}

function create_blur_effect(_sprite, _index, _x, _y, _xscale)
{
	var q = create_afterimage(_sprite, _index, _x, _y, _xscale, 0.8)
	q.image_blend = c_white
	q.type = afterimagetype.fade
	return q
}



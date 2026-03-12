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



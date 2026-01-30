image_speed = 0
depth = 50
gateinfo = ds_list_create()
function create_gate_layer(_sprite, _index, _x, _y, _hsp, _vsp, _parallax = false)
{
	var q =
	{
		sprite_index: _sprite,
		image_index: _index,
		bgx: _x,
		bgy: _y,
		hsp: _hsp,
		vsp: _vsp,
		parallax: _parallax
	}
	ds_list_add(gateinfo, q)
	return q;
}
create_gate_layer(spr_gate_waybackBG, 3, 0, 100, 0, 0)
create_gate_layer(spr_gate_waybackBG, 2, 0, 0, -2, 5)
create_gate_layer(spr_gate_waybackBG, 1, 0, 0, 0.45, 0)
create_gate_layer(spr_gate_waybackBG, 0, 0, 0, 0.35, 0)
bgalpha = 1
visibleradius = 250
textalpha = 0
drawing = 0
scoreViewer = -4
create_uparrow()
createdToppins = false
jingle = "event:/Music/W1/Monolith Mangrove/titlecard"
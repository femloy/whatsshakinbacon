function scr_player_skateboardIntro()
{
	hsp = 0
	vsp = 0
	image_speed = 0.35
	if animation_end()
	{
		sprite_index = spr_player_skate_idle
		state = states.skateboardmove
		prevOnSlope = false
		onSlope = false
		slopeObj = -4
		wasRamp = false 
		movespeed = 12
	}
}

function scr_player_skateboardAim()
{
	hsp = 0
	vsp = 0
	if animation_end()
	{
		if key_up
		{
			state = states.skateboardramp
			verticalMovespeed = -12
			movespeed = 0
		}
		else
		{
			state = states.skateboardramp
			verticalMovespeed = 0
			movespeed = 12
		}
	}
}

function scr_player_skateboardwall()
{
}

function scr_player_skateboardhitwall()
{
	image_speed = 0.35
	get_input()
	hsp = movespeed * xscale
	if grounded
		movespeed = approach(movespeed, 0, 0.5)
	if movespeed == 0
	{
		sprite_index = spr_player_skate_idle
		image_index = 0
		state = states.skateboard
	}
	if grounded
		sprayCans = 4
}

function scr_player_skateboardramp()
{
	get_input()
	hsp = movespeed * xscale
	vsp = verticalMovespeed
	if place_meeting(x + hsp, y, obj_solid) || place_meeting(x, y + vsp, obj_solid)
	{
		xscale *= -1
		vsp = -4
		state = states.skateboard
	}
}

function scr_player_skateboardmove()
{
}

function scr_player_skateboard()
{
	get_input()
	hsp = movespeed * xscale
	movespeed = approach(movespeed, 15, 0.1)
	image_speed = 0.35
	buffers.dashcloud--
	if buffers.dashcloud <= 0 && grounded
	{
		buffers.dashcloud = 12
		create_particleStatic(spr_dashcloud1, x, y, xscale, 1)
	}
	
	if jumpstop == false && !key_jump && vsp < 0.5
	{
		jumpstop = true
		vsp /= 10
	}
	
	slope_momentum(0.25, 0.4)
	
	var _grounded = grounded || place_meeting(x, y, obj_bouncybouncebounce)
	if jumpBuffer > 5 && _grounded
	{
		if place_meeting(x, y, obj_bouncybouncebounce)
		{
			var _obj = instance_place(x, y, obj_bouncybouncebounce)
			if !_obj.active
			{
				exit;
			}
			else
			{
				_obj.active = false
				_obj.alarm[0] = 30
			}
		}
		jumpBuffer = false
		jumpStop = false
		image_index = 0
		sprite_index = spr_player_pizzacarjump
		vsp = -10
		FMODevent_oneshot("event:/Sfx/Player/Transformations/Skateboard/jump", x, y)
	}
	if animation_end()
	{
		switch sprite_index
		{
			case spr_player_pizzacarjump:
				sprite_index = spr_player_pizzacarfall
				break
			case spr_player_pizzacarland:
				sprite_index = spr_player_pizzacar
				break
		}
	}
	
	if grounded && (sprite_index == spr_player_pizzacarjump || sprite_index == spr_player_pizzacarfall)
	{
		image_index = 0
		sprite_index = spr_player_pizzacarland
	}
	
	
	if place_meeting(x + hsp, y, obj_solid) && !place_meeting(x + hsp, y, obj_stupidcabbit)
	{
		var _hitwall = doBump(12, (abs(hsp) + 1))
		if _hitwall
		{
			xscale *= -1
			vsp = -4
		}
	}
}
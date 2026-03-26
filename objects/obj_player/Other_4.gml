var doorOBJ = asset_get_index($"obj_door{door}")

if instance_exists(doorOBJ)
{
	if hallway == 2
	{
		var _hallway = -4
		
		with doorOBJ 
			_hallway = instance_place(x, y, obj_hallway_vertical)
			
		if _hallway == -4
			exit;
			
		var _hallway2Size = _hallway.sprite_width
		
		if state == states.climbwall
			x = doorOBJ.x + (savedpos * (_hallway2Size / hallwaysize))
		else {
			x = doorOBJ.x + 16 + (savedpos * (_hallway2Size / hallwaysize) - 16)
		}
		
		y = doorOBJ.y - (32 * 6) * hallwayDirection
		vsp = savedspd
	}
	else 
	{
		if hallway
			x = doorOBJ.x + 16 + (32 * 6 * hallwayDirection)
		else
			x = doorOBJ.x + 16
			
		y = doorOBJ.y - 14
	}
}
if door == "BACKTOHUB"
{
	x = backtohubX
	y = backtohubY
}

if (place_meeting(x, y + 4, obj_ballofbeer) || place_meeting(x, y - 16, obj_ballofbeer))
{
	hallway = false
	state = states.crouch
}

if place_meeting(x, y, obj_door) || place_meeting(x, y, obj_exitgate) || place_meeting(x, y, obj_detective_door) || place_meeting(x, y, obj_levelgate) || place_meeting(x, y, obj_keydoor) && state == states.enterdoor && !instance_exists(obj_backtohub)
{
	blendAmount = 1
	blendSpeed = 0.35 / 17
	state = states.walkfront
	image_index = 0
	sprite_index = spr_player_walkfront
}

with obj_followplayer
{
	ds_queue_clear(followqueue)
	target_x = other.x
	target_y = other.y
	x = target_x
	y = target_y
}

with obj_hipnatuese
{
	if room == rank_room 
	{
		instance_destroy()
		instance_create(900, 900, obj_hipnatueseDead)
		return;
	}
	image_alpha = 0
	hsp = 0
	vsp = 0
	x = obj_player.x
	y = obj_player.y
}

roomstartX = x
roomstartY = y
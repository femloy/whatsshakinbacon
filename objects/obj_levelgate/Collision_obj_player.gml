var _rm = targetRoom
var _dr = "A"
if other.grounded && other.key_up && other.state == states.normal
{
	with other
	{
		hallway = false
		movespeed = 0
		vsp = 0
		hsp = 0
		state = states.enterdoor
		sprite_index = spr_player_entergate
		image_index = 0
		targetRoom = _rm
		door = _dr
		backtohubRoom = room
		backtohubX = other.x
		backtohubY = y
	}
	with obj_music
		stop_music()
}
var _jingle = jingle
var _group = texture_group
with other
{
	if image_index == image_number - 1 && sprite_index == spr_player_entergate && !instance_exists(obj_fadeout)
	{
		state = states.enterdoor
		sprite_index = spr_player_entergate
		image_index = image_number - 1
		global.level = other.level
		global.resetRoom = _rm
		if global.level == "tutorial"
		{
			load_textures([_group])
			generalReset()
			if !instance_exists(obj_fadeout)
				instance_create(x, y , obj_fadeout)
		}
		else 
		{
			if !instance_exists(obj_titlecard)
			{
				var _title = instance_create(0, 0, obj_titlecard)
				with _title
				{
					jingle = _jingle
					group = _group
				}
			}
		}
	}
}
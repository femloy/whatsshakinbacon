backgroundX += 1
backgroundY -= 1
backgroundAlpha = approach(backgroundAlpha, showBackground, 0.1)
depth = obj_player.depth + 5
shake = approach(shake, 0, 1)
fadeAlpha = approach(fadeAlpha, 1, 0.1)
get_input()
with obj_player
{
	hsp = 0
	vsp = 0
	image_speed = 0.35
	var targetx = SCREEN_WIDTH / 2
	var targety = SCREEN_HEIGHT / 2
	var point = point_direction(obj_player.x, obj_player.y, targetx, targety)
	var lx = lengthdir_x(2, point);
	var ly = lengthdir_y(2, point);
	x = approach(x, targetx, abs(lx));
	y = approach(y, targety, abs(ly));
	if animation_end()
		image_speed = 0
}
ranktimer = approach(ranktimer, 0, 1)
switch cutscenePart
{
	case 0:
		if fadeAlpha == 1
		{
			showRank = false
			ranktimer = 60 * 5
			cutscenePart++
			with obj_player
			{
				x -= camera_get_view_x(view_camera[0])
				y -= camera_get_view_y(view_camera[0])
				x = floor(x)
				y = floor(y)
			}
			room = rank_room
		}
		break
	case 1:
		if tutorial
		{
			whitefade = approach(whitefade, showWhite, 0.1)
			blackfade = approach(blackfade, showBlack, 0.1)
			if ranktimer == 0 && !showWhite
			{
				showWhite = true
				ranktimer = 60 * 1
			}
			if ranktimer == 0 && showWhite && !showBlack
			{
				showBlack = true
				ranktimer = 60 * 1
			}
			if ranktimer == 0 && showWhite && showBlack
			{
				with obj_player
				{
					generalReset()
					movespeed = 0
					vsp = 0
					hsp = 0
					state = states.enterdoor
					door = "BACKTOHUB"
					visible = true
					targetRoom = backtohubRoom
					instance_create(x, y, obj_fadeout)
					if instance_exists(obj_backtohub)
						instance_destroy(obj_backtohub)
				}
				global.level = noone
				global.resetRoom = noone
				fmod_studio_event_instance_stop(music, FMOD_STUDIO_STOP_MODE.IMMEDIATE)
				destroy = true
			}
		}
		else
		{
			if !showRank && ranktimer == 0
			{
				showRank = true
				rankIndex = 0
				obj_player.visible = false
				ranktimer = 60 * 5
				if gotoBackground != backgroundIndex
				{
					backgroundAlpha = 0
					backgroundIndex = gotoBackground
				}
			}
			else
			{
				rankIndex += 0.45
				rankIndex = clamp(rankIndex, 0, sprite_get_number(rankspr) - 1) 
				if rankIndex == sprite_get_number(rankspr) - 1 && showRank
					showRankText = true
				if ranktimer == 0
				{
					cutscenePart++
					alarm[0] = 40
					alarm[2] = 25
				}
			}
		}
		break
	case 2:
		break
}
if canContinue
{
	if key_jump2
	{
		canContinue = false
		cutscenePart = 2
		var t = instance_create(x, y, obj_rank_transition)
		t.blend = make_colour_rgb(col[0] * 255, col[1] * 255, col[2] * 255)
		fmod_studio_event_instance_stop(music, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT)
	}
}
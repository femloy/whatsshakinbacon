bgalpha = 1 - distance_to_object(obj_player) / visibleradius
ini_open(global.saveFile)
var _completed = ini_read_string(level, "Rank", "NONE") != "NONE"
ini_close()
if level != "tutorial" && _completed
{
	if distance_to_object(obj_player) < 300 && scoreViewer == -4
	{
		scoreViewer = instance_create(x + 12, camera_get_view_y(view_camera[0]) - 200, obj_scoreHub)
		with scoreViewer
		{
			targetY = other.y - 150
			ini_open(global.saveFile)
			var _level = other.level
			collect = ini_read_real(_level, "Highscore", 0)
			var _rank = ini_read_string(_level, "Rank", "D")
			if _rank == "D"
				rankIndex = 0
			if _rank == "C"
				rankIndex = 1
			if _rank == "B"
				rankIndex = 2
			if _rank == "A"
				rankIndex = 3
			if _rank == "S"
				rankIndex = 4
			if _rank == "P"
				rankIndex = 5
			ini_close()
		}
	}
	var i = 0
	if !createdToppins
	{
		createdToppins = true
		repeat (5) {
			var _toppin = instance_create(x, y + sprite_height / 2, obj_potableHubVisual)
			with _toppin
			{
				level = other.level
				potable = i
				spr_idle = potableSprites[potable].idle
				spr_move = potableSprites[potable].move
				spr_taunt = potableSprites[potable].taunt
			}
			i++
		}
	}
}
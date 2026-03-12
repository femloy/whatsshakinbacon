obj_player.state = -4
obj_player.x = -100
obj_player.y = -100
get_menu_input()
if key_down_pressed
	selectedLevel++
else if key_up_pressed
	selectedLevel--
selectedLevel = clamp(selectedLevel, 0, array_length(levels[selectedWorld]) - 1)

if key_right_pressed
{
	selectedLevel = 0
	selectedWorld++
}
else if -key_left_pressed
{
	selectedLevel = 0
	selectedWorld--
}
selectedWorld = clamp(selectedWorld, 0, array_length(levels) - 1)
potableIndex += 0.35
if key_jump_pressed
{
	var _levelDeets = levels[selectedWorld][selectedLevel]
	with obj_player
	{
		generalReset()
		targetRoom = _levelDeets[0]
		door = _levelDeets[2]
		global.level = _levelDeets[1]
		backtohubRoom = room
		backtohubX = x
		backtohubY = y
		global.resetRoom = _levelDeets[0]
		if !instance_exists(obj_fadeout)
				instance_create(x, y , obj_fadeout)
	}
}
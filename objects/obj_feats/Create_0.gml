BGX = 0
BGY = 0
depth = obj_pause.depth - 1
buffer = 0

achievement = []
selected = 0

switch global.level
{
	default:
	case "forest":
		array_push(achievement, achievements.waybackFodder)
		array_push(achievement, achievements.waybackTourist)
		break
}
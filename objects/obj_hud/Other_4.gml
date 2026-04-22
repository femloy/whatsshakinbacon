switch global.level
{
	case "forest":
		global.Srank = 19000
		tv.backindex = 0
		break
	case "city":
		global.Srank = 30000
		tv.backindex = 1
		break
	default:
		global.Srank = 0
		tv.backindex = 0
		break
}
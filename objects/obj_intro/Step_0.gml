switch scene
{
	case 0:
		timer = max(timer - 1, 0)
		if timer == 0
		{
			FMODevent_oneshot("event:/Sfx/General/Collects/collect", SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
			FMODevent_oneshot("event:/Sfx/Player/yay", SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
			scene++
			timer = 60 * 2
		}
		break
	case 1:
		logo_xs = easeOutElastic(easeVal2)
		logo_ys = easeOutElastic(easeVal)
		easeVal = min(easeVal + 1 / 60, 1)
		easeVal2 = min(easeVal2 + 1 / 40, 1)
		timer = max(timer - 1, 0)
		if timer == 0
		{
			FMODevent_oneshot("event:/Sfx/UI/slideClose")
			scene = 2
			spd = 0
		}
	break
	case 2:
		spd += 0.005
		logo_xs = max(logo_xs - spd, 0)
		logo_ys = max(logo_ys - spd, 0)
		logo_alpha = max(logo_alpha - spd, 0)
		if logo_alpha == 0
		{
			scene = 3
			timer = 30
		}
	break
	case 3:
		timer--
		if timer < 0
		{
			room_goto(initObject)
		}
		break
}
switch scene
{
	case 0:
		timer = max(timer - 1, 0)
		if timer == 0
		{
			logo_xs += 0.2
			logo_ys += 0.15
		}
		if logo_xs > 1
		{
			FMODevent_oneshot("event:/Sfx/General/Collects/bigcollect", SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
			FMODevent_oneshot("event:/Sfx/Player/yay", SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
			scene++
			timer = 60 * 2
		}
		break
	case 1:
		logo_xs = lerp(logo_xs, 1, 0.15)
		logo_ys = lerp(logo_ys, 1, 0.15)
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
			instance_destroy()
			instance_create(x, y, obj_intro_video)
		}
		break
}
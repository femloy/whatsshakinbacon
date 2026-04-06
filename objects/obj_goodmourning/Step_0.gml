switch scene
{
	case 0:
		y = SCREEN_HEIGHT / 2
		x = SCREEN_WIDTH / 2
		image_xscale = 0
		image_yscale = 0
		alarm[0] = 25
		scene = -1
		break
	case 1:
		image_alpha += 1 / 10
		image_xscale = approach(image_xscale, 0.7, 0.1)
		image_yscale = approach(image_yscale, 0.7, 0.1)
		y = approach(y, SCREEN_HEIGHT / 2, 64)
		if image_xscale == 0.7
			scene++
		break
	case 2:
		image_angle = lerp(image_angle, 5, 0.1)
		image_xscale = lerp(image_xscale, 1, 0.22)
		image_yscale = lerp(image_yscale, 1, 0.22)
		x = SCREEN_WIDTH / 2 + irandom_range(-1, 1)
		y = SCREEN_HEIGHT / 2 + irandom_range(-1, 1)
		if alarm[1] <= 0
			alarm[1] = 100
		break
	case 3:
		image_xscale = approach(image_xscale, 2, 0.22)
		image_yscale = approach(image_yscale, 0.5, 0.22)
		x = SCREEN_WIDTH / 2 + irandom_range(-5, 5)
		y = SCREEN_HEIGHT / 2 + irandom_range(-5, 5)
		if image_xscale == 2
		{
			scene = 4
			vsp = -15
			x = SCREEN_WIDTH / 2
			y = SCREEN_HEIGHT / 2
		}
		break
	case 4:
		image_alpha -= 1 / 60
		image_xscale = lerp(image_xscale, 1, 0.5) * scaled
		image_yscale = lerp(image_yscale, 1, 0.5) * scaled
		scaled = approach(scaled, 0, 1 / 150)
		image_angle += 360 / 25
		vsp += 0.5
		y += vsp
		x += 4
		if image_alpha <= 0
			instance_destroy()
		break
}
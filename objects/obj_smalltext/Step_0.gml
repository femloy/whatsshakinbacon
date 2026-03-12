if stay
{
	image_xscale = lerp(image_xscale, 1, 0.35)
	image_yscale = lerp(image_yscale, 1, 0.35)
}
else {
	if image_alpha <= 0
		instance_destroy()
	image_alpha-= 0.05
	image_xscale = approach(image_xscale, 0, 0.05)
	image_yscale = approach(image_yscale, 0, 0.05)
}
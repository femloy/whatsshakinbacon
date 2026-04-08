get_input()
if key_jump_pressed
{
	instance_destroy()
	instance_create(x, y, obj_intro)
}
if image_xscale < 1
{
	image_xscale += 1 / 30
	image_yscale += 1 / 30
	image_alpha += 1 / 30
}
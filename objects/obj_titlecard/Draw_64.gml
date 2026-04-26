if scene == 1 || scene == 2
{
	titlecardName.x = irandom_range(-1, 1)
	titlecardName.y = irandom_range(-1, 1)
	draw_sprite(titlecardSprite, 0, 0, 0)
	if isMilton
		draw_sprite(titlecardMilton, titlecardMiltonIndex, 0, 0)
	draw_set_alpha(titlecardName.alpha)
	draw_sprite(titlecardName.sprite, 0, titlecardName.x, titlecardName.y)
	draw_set_alpha(1)
}

if !surface_exists(fadeSurface)
	fadeSurface = surface_create(SCREEN_WIDTH, SCREEN_HEIGHT)
surface_set_target(fadeSurface)
draw_clear_alpha(c_black, 0)
draw_set_color(c_black)
draw_rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, false)
draw_set_color(c_white)
gpu_set_blendmode(bm_subtract)
var _s = circleSize / 9
draw_sprite_ext(spr_transition_mildred, 0, SCREEN_WIDTH / 2 + (96 * _s), SCREEN_HEIGHT / 2 - (270 * _s), circleSize, circleSize, 0, c_white, 1)
reset_blendmmode()
surface_reset_target()

draw_set_alpha(fadeAlpha)
draw_surface(fadeSurface, 0, 0)
draw_set_alpha(1)

if !surface_exists(rankSurf)
	rankSurf = surface_create(room_width, room_height)
surface_set_target(rankSurf)
draw_clear_alpha(c_black, 0)
draw_set_alpha(fadeAlpha)
draw_set_color(c_white)
draw_rectangle(0, 0, room_width, room_height, false)
draw_set_color(c_white)
draw_set_alpha(1)

var _xx = SCREEN_WIDTH / 2 + irandom_range(shake, -shake)
var _yy = SCREEN_HEIGHT / 2 + irandom_range(shake, -shake)
if showRank
{
	draw_sprite(rankspr, rankIndex, _xx, _yy)
	pal_swap_set(obj_player.sprites.player_pal, obj_player.palette_index, false)
	draw_sprite(rankspr, rankIndex, _xx, _yy)
	shader_reset()
	pattern_draw(rankspr, rankIndex, _xx, _yy, 1, 1, 0, c_white, 1, global.patternSpr, spr_playerPatColors)
}
if showRankText && ranktextSpr != -4
	draw_sprite(ranktextSpr, 0, _xx, _yy)
surface_reset_target()
draw_surface(rankSurf, 0, 0)

if cutscenePart == 2
{
	colorAlpha = approach(colorAlpha, 1, 0.1)
	shader_set(shd_fullshade)
	shader_set_uniform_f_array(uniform1, [col[0], col[1], col[2]])
	shader_set_uniform_f_array(uniform2, [col2[0], col2[1], col2[2]])
	draw_set_alpha(colorAlpha)
	draw_surface(rankSurf, 0, 0)
	draw_set_alpha(1)
	shader_reset()
}
draw_set_font(global.bigfont);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

for (var i = 0; i < array_length(text); i++)
{
    var t = text[i];
    if t[0]
		draw_text_oyh(48, 48 + (32 * i), t[1]);
}

_xx = SCREEN_WIDTH - (116 * array_length(toppins)) - 64
for (var i = 0; i < array_length(toppins); i++)
{
    var t = toppins[i];
	if t[0]
	{
		draw_sprite_ext(spr_toppinrank, t[3], _xx + (116 * i), t[2], 1, 1, 0, t[1] ? c_white : c_black, 1)
		t[2] = approach(t[2], SCREEN_HEIGHT - 135, 25)
	}
}

if canContinue
{
	draw_set_font(global.creditsfont)
	draw_set_color(c_white)
	draw_set_halign(fa_center)
	draw_text_oyh(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 64, "[wave][J] Continue")
	draw_set_alpha(1)
}
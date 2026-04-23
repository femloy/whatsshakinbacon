if !instance_exists(obj_option) && !instance_exists(obj_feats)
{
	if active
	{
		shader_set(shd_wave)
		shader_set_uniform_f(timeUniform, waveTime)
		waveTime++
		shader_set_uniform_f(frequencyUniform, freq)
		shader_set_uniform_f(amplitudeUniform, amp)
		draw_sprite(screenSprite, 0, 0, 0)
		shader_reset()
		draw_set_alpha(backdrop.alpha)
		draw_sprite_tiled(spr_pause_bg, 0, backdrop.x, backdrop.y)
		backdrop.x -= 0.1
		backdrop.y -= 0.1
		draw_set_alpha(1)
	}
	for (var i = 0; i < array_length(backgroundhearts); i++)
	{
		var q = backgroundhearts[i]
		draw_set_alpha(q.image_alpha)
		draw_sprite(q.sprite_index, q.image_index, q.x, q.y)
		draw_set_alpha(1)
	}
	var xx = SCREEN_WIDTH / 2;
	var yy = SCREEN_HEIGHT / 2 - (52 * (array_length(options) - 1) / 2)
	for (var i = 0; i < array_length(options); i++) 
	{
		var q = options[i]
		if !active 
			q.offsetX = lerp(q.offsetX, -SCREEN_WIDTH, 0.2)
		else 
		{
			q.offsetX = lerp(q.offsetX, 0, 0.2)
		}
		if (is_struct(q))
		{
			draw_set_font(global.bigfont)
			draw_set_colour(c_black)
			draw_set_color(selected == i ? c_white : c_gray)
			draw_set_halign(fa_center)
			draw_text_oyh(xx + q.offsetX, yy, lang_get_phrase(q.option))
			draw_set_alpha(q.icon.alpha)
			draw_sprite(spr_pauseicons, q.icon.index, floor(xx + irandom_range(-1, 1) - (string_width(lang_get_phrase(q.option)) / 2) - 80) + q.offsetX + 42, floor(yy + irandom_range(-1, 1)))
			draw_set_alpha(1)
			q.icon.alpha = approach(q.icon.alpha, selected == i, 0.1)
			yy += 52
		}
	}
	draw_sprite_ext(spr_pauseBorder, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, border_size, border_size, 0, c_white, 1)
	for (var i = 0; i < array_length(secrets); i++)
	{
		var q = secrets[i]
		var _XX = q.x
		var _YY = q.y
		if !q.secret
		{
			_XX = q.x + irandom_range(-1, 1)
			_YY = q.y + irandom_range(-1, 1)
		}
		if active
		{
			if border_size == 1
			{
				var _isSecret = global.secretCount > q.index
				if q.secret != _isSecret
				{
					q.scale = 2
					q.secret = _isSecret
				}
			}
		}
		q.scale = approach(q.scale, 1, 0.1)
		if global.level != noone
			draw_sprite_ext(q.secret ? spr_pauseHeart_full : spr_pauseHeart_empty, q.index, _XX, _YY, q.scale, q.scale, 0, c_white, backdrop.alpha / 0.4)
	}
	if global.level != noone
	{
		draw_set_alpha(treasureAlpha)
		draw_sprite(spr_treasure_pause, global.treasure ? 0 : 1, 864, 462)
		draw_set_alpha(1)
	}
	treasureAlpha = approach(treasureAlpha, active, 0.1)
	border_size = lerp(border_size, active ? 1 : 2, 0.3)
	if active
	{
		if tipText != ""
		{
			draw_set_font(global.creditsfont)
			draw_set_color(c_white)
			draw_set_halign(fa_center)
			draw_text_oyh(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 64, tipText)
			draw_set_alpha(1)
		}
	}
}
draw_set_colour(c_white)
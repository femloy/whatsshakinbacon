if !instance_exists(obj_option)
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
		draw_set_alpha(graphBack.alpha)
		draw_set_color(#ffb7ad)
		draw_rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, false)
		draw_set_color(c_white)
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
	var yy = SCREEN_HEIGHT / 2 - (90 * ((array_length(options) - 1) / 2))
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
			draw_sprite(spr_pause_letter, selected != i, xx + q.offsetX, yy + (90 * i))
			draw_set_font(global.bigfont)
			draw_set_color(selected == i ? c_white : #b871a6)
			draw_set_halign(fa_center)
			draw_text_oyh(xx + q.offsetX + (sprite_get_width(spr_pauseicons) / 4 * q.icon.alpha), yy + (90 * i), lang_get_phrase(q.option))
			draw_set_alpha(q.icon.alpha)
			draw_sprite(spr_pauseicons, q.icon.index, floor(xx + irandom_range(-1, 1) - (string_width(lang_get_phrase(q.option)) / 2) - 50) + q.offsetX + 42, floor(yy + (90 * i) + irandom_range(-1, 1)))
			draw_set_alpha(1)
			q.icon.alpha = approach(q.icon.alpha, selected == i, 0.1)
		}
	}
	draw_sprite_ext(spr_pauseBorder, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, graphBorderSize, graphBorderSize, 0, c_white, 1)
	for (var i = 0; i < array_length(secrets); i++)
	{
		var q = secrets[i]
		var _XX = q.x
		var _YY = q.y + wave(-5, 5, 5, i * 360)
		if !q.secret
		{
			_XX = q.x + irandom_range(-1, 1)
			_YY = q.y + irandom_range(-1, 1)
		}
		if active
		{
			if graphBorderSize == 1
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
			draw_sprite_ext(q.secret ? spr_pauseHeart_full : spr_pauseHeart_empty, q.index, _XX, _YY, q.scale, q.scale, 0, c_white, graphBack.alpha / 0.4)
	}
	if global.level != noone
	{
		draw_set_alpha(treasureAlpha)
		draw_sprite(spr_treasure_pause, global.treasure ? 0 : 1, 851, 457)
		treasureAlpha = approach(treasureAlpha, active, 0.1)
		draw_set_alpha(1)
	}
	graphBorderSize = lerp(graphBorderSize, active ? 1 : 2, 0.3)
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
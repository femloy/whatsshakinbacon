var _x = SCREEN_WIDTH / 2
var _y = SCREEN_HEIGHT - 100
draw_set_alpha(textAlpha)
draw_set_font(global.creditsfont)
draw_set_color(c_white)
draw_set_halign(fa_center)
draw_text_oyh(_x, _y, palettes[selected].pName)
draw_text_oyh(_x, _y + 50, palettes[selected].desc)
draw_set_alpha(1)
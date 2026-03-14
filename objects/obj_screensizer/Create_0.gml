depth = -998
gameframe_init()
gameframe_caption_text = "Fidelity Hotel"
gameframe_caption_font = font_caption
gameframe_caption_icon = spr_ico
gameframe_caption_text_align = fa_center
mouse_in_window = false
gameframe_visible_time = 60
mouseX = mouse_x
mouseY = mouse_y

displayWidth = 960
displayHeight = 540

darksurf = surface_create(displayWidth + 32, displayHeight + 32)
dark = false

gameSurface = -4
screen_surf = -4
size = 1
#macro SCREEN_WIDTH obj_screensizer.displayWidth
#macro SCREEN_HEIGHT obj_screensizer.displayHeight
game_set_speed(60, gamespeed_fps)
x = 0
y = 0
alarm[0] = 60
global.debug = false
kettle = {}
kettle.x = 124
kettle.y = 54
kettle.index = 0
kettle.kx = kettle.x
kettle.ky = kettle.y
kettle.rankScale = 0
kettle.previousRank = 0
kettle.cloudIndex = 0
kettle.offset = 0
kettle.shake = 0
kettle.lastcollect = -4
kettle.colorarray = []
kettle.badnum = []
kettle.rankPerc = 0
depth = -500

collectVis = ds_list_create()

tv = {}
tv.state = states.normal
tv.sprite_index = spr_tv_off
tv.image_index = 0
tv.image_speed = 0.35
tv.x = SCREEN_WIDTH - 132
tv.y = 73
tv.expressionSprite = spr_tv_idle
tv.expressionTimer = 0
tv.switchindex = 0
tv.offset = 0
tv.backindex = 0
tv.idle = 100

combometer = {}
combometer.x = 811
combometer.y = 237
combometer.arrowx = combometer.x
combometer.vsp = 0
combometer.state = -1
combometer.lights = []
combometer.shake = 0
combometer.combo = 0
repeat (4)
	array_push(combometer.lights, {on: true, sprite: spr_comboLights, x: 0, y: 0, index: 0})

bar = {}
bar.x = SCREEN_WIDTH / 2
bar.y = SCREEN_HEIGHT - 100
bar.sparkIndex = 0
bar.spacePos = 0
bar.chunkMax = 1
bar.endIndex = 0
bar.ending = false
bar.ended = false

lapbar = {}
lapbar.time = 60 * 10
lapbar.freeze = 0
lapbar.color = 0

hudVisible = function()
{
	var isHub = string_pos("hotel", string_letters(room_get_name(room))) > 0 && !global.escape.active
	var _rooms = room == rm_intro ||room == rank_room || room == Levelselect || room == Mainmenu || isHub || (global.level == "tutorial") || room == timesup_room || room == credits_room
	return !_rooms
}

global.Srank = 22000
idle = 60 * 2
alarm[0] = 60

discoAlpha = 0
discoColors = [c_red, c_aqua, c_fuchsia, c_yellow, c_lime]
discoColor = 0
musicBeat = 0
musicBar = 0
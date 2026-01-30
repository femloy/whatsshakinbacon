x = 0
y = 0
depth = 15
ds_list_clear(global.saveroom)
ds_list_clear(global.escaperoom)
ds_list_clear(global.followers)
canContinue = false

fadeAlpha = 0
cutscenePart = 0
obj_player.state = -4
global.combo.timer = 0

showRank = false
showRankText = false
rankIndex = 0

tutorial = global.level == "tutorial"
if tutorial && global.level_timer < 60
{
	ini_open(global.saveFile)
	
	if ini_read_real("General", "Lap", false) == false
	{
		scr_transfotip("[wave]All lap 2 portals unlocked!")
		ini_write_real("General", "Lap", true)
	}
	
	ini_close()
}

whitefade = 0
blackfade = 0
showWhite = false
showBlack = false

with obj_music
{
	stop_music()
	if FMODevent_isplaying(escapeInst)
		fmod_studio_event_instance_stop(escapeInst, FMOD_STUDIO_STOP_MODE.IMMEDIATE)
}

global.escape.active = false
global.escape.timer = (60 * 60) * 2

FMODstopAll()

	var _rankIndex = 0;
	if global.collect >= global.Crank
		_rankIndex = 1
	if global.collect >= global.Brank
		_rankIndex = 2 
	if global.collect >= global.Arank
		_rankIndex = 3
	if global.collect >= global.Srank
		_rankIndex = 4
	if scr_Prank()
		_rankIndex = 5
	
music = FMODcreate_event("event:/Music/General/ranks");
if !tutorial
{
	fmod_studio_event_instance_set_parameter_by_name(music, "state", _rankIndex)
	fmod_studio_event_instance_start(music)
}

rankspr = spr_rankD
ranktextSpr = lang_get_asset("spr_rankD_text")
var _col = #305078
var _col2 = #112948
gotoBackground = 0
switch _rankIndex
{
	case 0:
		gotoBackground = 1
		rankspr = spr_rankD
		ranktextSpr = lang_get_asset("spr_rankD_text")
		_col = #305078
		_col2 = #112948
		break
	case 1:
		gotoBackground = 2
		rankspr = spr_rankC
		ranktextSpr = lang_get_asset("spr_rankC_text")
		_col = #60d048
		_col2 = #007000
		break
	case 2:
		gotoBackground = 3
		rankspr = spr_rankB
		ranktextSpr = lang_get_asset("spr_rankB_text")
		_col = #30a8f8
		_col2 = #2850a8
		break
	case 3:
		gotoBackground = 4
		rankspr = spr_rankA
		ranktextSpr = lang_get_asset("spr_rankA_text")
		_col = #f80000
		_col2 = #500000
		break
	case 4:
		gotoBackground = 5
		rankspr = spr_rankS
		ranktextSpr = lang_get_asset("spr_rankS_text")
		_col = #e09000
		_col2 = #982800
		break
	case 5:
		rankspr = spr_rankP
		ranktextSpr = -4
		_col = #ff0c9f
		_col2 = #c3074f
		break
}
uniform1 = shader_get_uniform(shd_fullshade, "lightest");
uniform2 = shader_get_uniform(shd_fullshade, "darkest");
rankSurf = -4

col = [ color_get_red(_col) / 255, color_get_green(_col) / 255, color_get_blue(_col) / 255 ]
col2 = [ color_get_red(_col2) / 255, color_get_green(_col2) / 255, color_get_blue(_col2) / 255 ]
colorAlpha = 0

ranktimer = tutorial ? 60 : 60 * 3

shake = 0
textPos = 0
text = []
array_push(text, [ false, $"SCORE: {global.collect}" ])
array_push(text, [ false, $"TIME: {timeString(global.level_timer)}" ])
array_push(text, [ false, $"DAMAGE: DUMMY" ])
array_push(text, [ false, $"HIGHEST COMBO: {global.combo.highest}" ])

toppinPos = 0
toppins = []

array_push(toppins, [ false, global.toppins.bean, SCREEN_HEIGHT, 0])
array_push(toppins, [ false, global.toppins.cup, SCREEN_HEIGHT, 1])
array_push(toppins, [ false, global.toppins.lime, SCREEN_HEIGHT, 2])
array_push(toppins, [ false, global.toppins.bag, SCREEN_HEIGHT, 3])
array_push(toppins, [ false, global.toppins.orange, SCREEN_HEIGHT, 4])

backgroundX = 0
backgroundY = 0
backgroundAlpha = 0
backgroundIndex = 0
showBackground = false
if !tutorial
	alarm[3] = 35
destroy = false
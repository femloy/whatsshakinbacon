fade_alpha = approach(fade_alpha, 0, 0.1)
roomPaletteIndex = approach(roomPaletteIndex, selectedFile + 1, 0.1)
switch scene
{
	case -2:
		getMenu_input()
		if key_jump2
		{
			dark = false
			FMODevent_oneshot("event:/Sfx/UI/Mainmenu/turnon")
			scene = -1
			alarm[0] = 60
			alarm[3] = 5
			if created == true
			{
				fmod_studio_event_instance_start(music)
				fmod_studio_event_instance_set_paused(music, false)
			}
		}
	case -1:
		break
	case 0:
		getMenu_input()
		if instance_exists(obj_option)
			exit;
		if key_start2
		{
			FMODevent_oneshot("event:/Sfx/UI/Pause/menuselect")
			instance_create(x, y, obj_option)
			exit;
		}
		hudAlpha = approach(hudAlpha, 1, 0.1)
		var q = saveFiles[selectedFile]
		selectBuffer = approach(selectBuffer, 0, 1)
		if key_jump2 && selectBuffer == 0
		{
			global.saveFile = q.savePath
			alarm[1] = 60 * 3
			FMODevent_oneshot("event:/Sfx/General/Collects/bigcollect", SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
			FMODevent_oneshot("event:/Sfx/UI/Mainmenu/selectmovie")
			scene = 1
			alarm[2] = 120
			fmod_studio_event_instance_stop(music, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT)
			ini_open(global.saveFile)
			ini_write_real("General", "created", true)
			ini_close()
			TVsprite = spr_mainmenu_tv
			TVindex = selectedFile + 1
			exit;
		}
		var move = key_right2 + key_left2
		if move != 0
		{
			selectedFile += -move
			FMODevent_oneshot("event:/Sfx/UI/Pause/menumove")
			//FMODevent_oneshot("event:/Sfx/UI/Mainmenu/changemovie")
			TVsprite = spr_mainmenu_tvStatic
			selectedFile = clamp(selectedFile, 0, 3)
			if saveFiles[selectedFile].created == true
				alarm[5] = 6
			else
				alarm[5] = -1
			exit;
		}
		if TVsprite == spr_mainmenu_tv
			TVindex = selectedFile + 1
		else {
			TVindex += 0.35
		}
		
		percentageReal = q.completion
		if TVsprite != spr_mainmenu_tvStatic
			percentage = lerp(percentage, percentageReal, 0.25)
		for (var i = 0; i < array_length(saveFiles); i++)
		{
			var q = saveFiles[i]
			q.faceAlpha = approach(q.faceAlpha, (selectedFile == q.file) && q.created ? 1 : 0, 0.1)
			q.movie.x = lerp(q.movie.x, selectedFile == q.file ? q.movie.saveX + 80 : q.movie.saveX, 0.25)
			q.movie.y = lerp(q.movie.y, selectedFile == q.file ? q.movie.saveY - 5 : q.movie.saveY, 0.25)
		}
		
		if key_slap2
		{
			scene = 3
			selectedMenu = 0
			quitText = choose(
			"ARE YOU SURE YOU WANT TO QUIT?",
			"DONT LEAVE ME! IM SORRY!",
			"YOULL BE BACK, RIGHT?",
			"PLEASE DONT LEAAVE..",
			"I LOVE YOU THOUGH!",
			"DONT QUIT PLEASE!")
		}
		
		if key_taunt2
		{
			var q = saveFiles[selectedFile]
			if file_exists(q.savePath)
				file_delete(q.savePath)
			saveFiles[selectedFile] = new createSave(selectedFile)
			TVsprite = spr_mainmenu_tvStatic
		}
		break
	case 1:
		hudAlpha = approach(hudAlpha, 0, 0.15)
		for (var i = 0; i < array_length(saveFiles); i++)
		{
			var q = saveFiles[i]
			if selectedFile != q.file
			{
				q.movie.alpha = approach(q.movie.alpha, 0, 0.05)
				q.movie.x = q.movie.saveX + irandom_range(-1, 1)
				q.movie.y = q.movie.saveY + irandom_range(-1, 1)
			}
			else
				q.movie.scale = approach(q.movie.scale, 2.5, 0.001)
			
		}
		break
	case 3:
		getMenu_input()
		var move = key_right2 + key_left2
		if move != 0
		{
			selectedMenu += -move
			selectedMenu = clamp(selectedMenu, 0, 1)
			FMODevent_oneshot("event:/Sfx/UI/Pause/menumove")
			exit;
		}
		if key_jump2
		{
			if selectedMenu == 0
			{
				selectBuffer = 10
				scene = 0
				exit;
			}
			else if selectedMenu == 0
				game_end()
			exit;
		}
		break
	case 2:
		hudAlpha = approach(hudAlpha, 0, 0.1)
		for (var i = 0; i < array_length(saveFiles); i++)
		{
			var q = saveFiles[i]
			if selectedFile != q.file
			{
				q.movie.alpha = approach(q.movie.alpha, 0, 1)
				q.movie.x = q.movie.saveX + irandom_range(-1, 1)
				q.movie.y = q.movie.saveY + irandom_range(-1, 1)
			}
			else
			{
				q.movie.scale = approach(q.movie.scale, 100, 2)
				if moviefade > 0
					moviefade -= 5
				else
					moviefade = 0
				moviefadeC = make_color_rgb(moviefade, moviefade, moviefade)
			}
			
		}
		break
		
}
#macro doGroundpoundCheck ((key_down_pressed && global.dirGround) || (key_groundpound_pressed))
#macro doSuperjumpCheck ((key_up && global.dirGround) || (key_superjump))

function do_state()
{
	switch state
	{
		case states.normal:
			scr_player_normal()
		break
		case states.jump:
			scr_player_jump()
		break
		case states.crouch:
			scr_player_crouch()
		break
		case states.mach2:
			scr_player_mach2()
		break
		case states.machslide:
			scr_player_machslide()
		break
		case states.mach3:
			scr_player_mach3()
		break
		case states.machturn:
			scr_player_machturn()
		break
		case states.hitwall:
			scr_player_hitwall()
		break
		case states.superjumpprep:
			scr_player_superjumpprep()
		break
		case states.superjump:
			scr_player_superjump()
		break
		case states.freefallland:
			scr_player_freefallland()
		break
		case states.taunt:
			scr_player_taunt()
		break
		case states.tumble:
			scr_player_tumble()
		break
		case states.climbwall:
			scr_player_climbwall()
		break
		case states.groundpound:
			scr_player_groundpound()
		break
		case states.groundpoundstart:
			scr_player_groundpoundstart()
		break
		case states.enterdoor:
			scr_player_enterdoor()
		break
		case states.grab:
			scr_player_grab()
		break
		case states.hauling:
			scr_player_hauling()
		break
		case states.finishingblow:
			scr_player_finishingblow()
		break
		case states.uppercut:
			scr_player_uppercut()
		break
		case states.hurt:
			scr_player_hurt()
		break
		case states.ladder:
			scr_player_ladder()
		break
		case states.buzzsaw:
			scr_player_buzzsaw()
		break
		case states.walkfront:
			scr_player_walkfront()
		break
		case states.parry:
			scr_player_parry()
		break
		case states.surfing:
			scr_player_surfing()
		break
		case states.diveboard:
			scr_player_diveboard()
		break 
        case states.ski:
			scr_player_ski()
		break
		case states.skibounce:
			scr_player_skibounce()
			break
		case states.skirow:
			scr_player_skirow()
			break
		case states.hammerattack:
			scr_player_hammerattack()
			break
		case states.hammertwirl:
			scr_player_hammertwirl()
			break
		case states.snowball:
			scr_player_snowball()
			break
		case states.snowballjump:
			scr_player_snowball_jump()
			break
		case states.snowballwall:
			scr_player_snowball_wall()
			break
		case states.skateboard:
			scr_player_skateboard()
			break
		case states.skateboardintro:
			scr_player_skateboardIntro()
			break
		case states.skateboardmove:
			scr_player_skateboardmove()
			break
		case states.skateboardhitwall:
			scr_player_skateboardhitwall()
			break
		case states.skateboardramp:
			scr_player_skateboardramp()
			break
		case states.skateboardwall:
			scr_player_skateboardwall()
			break
		case states.skateboardaim:
			scr_player_skateboardAim()
			break
		case states.slip:
			scr_player_slip()
			break
		case states.coconutintro:
			scr_player_coconut_intro()
			break
		case states.coconutgun:
			scr_player_coconut_gun()
			break
		case states.coconutshoot:
			scr_player_coconut_shoot()
			break
		case states.gunk:
			scr_player_gunk()
			break
		case states.gunkIntro:
			scr_player_gunkIntro()
			break
		case states.gunkMove:
			scr_player_gunkMove()
			break
		case states.noclip:
			get_input()
			var spd = key_attack ? 20 : 10
			var move = key_right + key_left, move2 = key_down - key_up
			y += move2 * spd
			x += move * spd
			hsp = 0
			vsp = 0
			if key_jump_pressed
				state = states.normal
			break
	}
}

function check_grabbed_solid(_player)
{
	if !place_meeting(x, y, obj_destructibles) && (scr_solid(x, y) || collision_line(x, y, _player.x, _player.y, obj_solid, false, true) != -4)
	{
		var _dist = abs(x - obj_player.x)
		x = _player.x
		y = _player.y
		if !scr_solid(x + _player.xscale, y)
		{
			var i = 0
			while !scr_solid(x + _player.xscale, y)
			{
				x += _player.xscale
				i++
				if i > _dist
					break
			}
			if scr_solid(x + _player.xscale, y)
			{
				var i = 0
				while scr_solid(x + _player.xscale, y)
				{
					x -= _player.xscale
					i++
					if i > _dist
						break
				}
			}
		}
	}
	
}

function hurt_player(_obj = noone)
{
	with obj_player
	{
		var _cantHurtStates = [states.skateboard, 
			states.skateboardaim, 
			states.skateboardhitwall, 
			states.skateboardintro, 
			states.skateboardmove, 
			states.skateboardramp, 
			states.skateboardwall,
			states.coconutgun,
			states.coconutintro,
			states.coconutjump,
			states.coconutshoot,
			states.parry,
		]
		if array_contains(_cantHurtStates, state) || i_frame > 0
			exit;
		
		scr_sleep(100)
		add_party_time(-5, 10)
		FMODevent_oneshot("event:/Sfx/Player/hurt", x, y)
		if irandom(100) <= 25
			fmod_studio_event_instance_start(soundsHurt)
		global.collect -= 100
		if global.collect < 0
			global.collect = 0
		global.damage_count++
		global.combo.timer -= 25
		global.combo.timer = clamp(global.combo.timer, 0, 60)
		tv_anim(spr_tv_hurt, 60 * 3)
		with obj_hud
			array_push(kettle.badnum, {x: kettle.x + 90, y: kettle.y, alpha: 1, text: "-100"})
		i_frame = 100
		var sameFace = true
		var facing = xscale
		if _obj != noone
		{
			var facing = sign(x - _obj.x)
			sameFace = xscale == facing
			//if facing != 0
				//xscale = facing
		}
		hsp = 8 * facing
		sprite_index = !sameFace ? spr_player_hurt : spr_player_hurt2
		flash = true
		state = states.hurt
		vsp = -12
		repeat (8)
		{
			create_particleDebri(spr_slapstar, irandom_range(0, sprite_get_number(spr_slapstar)), x, y, 1, -5)
			create_particleDebri(asset_get_index($"spr_collect{irandom_range(1, 5)}"), 0, x, y, 1, -5)
		}
		create_particleStatic(spr_hurteffect, x, y, 1)
		create_particleStatic(spr_parryeffect, x, y, 1)
	}	
}

function doBump(iterations, offset = 4)
{
	var old_x = x;
	var old_y = y;
	x += (xscale * offset);
	var ty = try_solid(0, -1, obj_solid, iterations);
	x = old_x;
	if ty != -1
	{
		y -= ty;
		x += xscale;
		if (scr_solid(x, y))
		{
			x = old_x;
			y = old_y;
			return true;
		}
		return false;
	}
	return true;
}

function try_solid(xoffset, yoffset, object, iterations)
{
	var old_x = x;
	var old_y = y;
	var n = -1;
	
	for (var i = 0; i < iterations; i++)
	{
		x += xoffset;
		y += yoffset;
		
		if !scr_solid(x, y)
		{
			n = i + 1;
			break;
		}
	}
	
	x = old_x;
	y = old_y;
	return n;
}

function scr_Prank()
{
	return (global.treasure && global.collect >= global.Srank && !global.combo.dropped && global.secretCount == 3 && global.escape.party && global.prankenemy_killed)
}

function generalReset()
{
	instance_destroy(obj_comboTitle)
	instance_destroy(obj_hipnatuese)
	ds_list_clear(global.saveroom)
	ds_list_clear(global.escaperoom)
	ds_list_clear(global.followers)
	fmod_studio_system_set_parameter_by_name("musicfade", 0, false)
	global.level_timer = 0
	global.collect = 0
	global.secretCount = 0
	global.detective = false
	global.treasure = false
	global.hasFlag = false
	global.key = false
	global.prankenemy_killed = false
	global.prankenemy_cankill = true
	global.tauntcount = 0
	global.damage_count = 0
	obj_player.door = "A"
	obj_player.visible = true
	obj_player.hallway = false
	obj_player.super = false
	obj_player.xscaleMulti = 1
	obj_player.yscaleMulti = 1
	obj_player.hitstun.is = false
	obj_player.supertaunt = 0
	obj_player.poison = 0
	obj_player.canSupertaunt = false
	
	with obj_hud
	{
		tv.sprite_index = spr_tv_off
		combometer.y = -128
		combometer.state = -1
		musicBar = 0
		musicBeat = 0
		kettle.previousRank = 0
		kettle.rankScale = 1
	}
	
	global.escape = 
	{
		active: false,
		timer: (60 * 60) * 2,
		party: false,
	}
	
	global.pumpkins = {
		count: 0, 
		amount: 12, 
		activeStein: false}
		
	global.combo = {
		dropped: false,
		amt: 0,
		timer: 60,
		previouscombo: 0,
		savecombo: 0,
		highest: 0,
	}
	
	global.toppins = {
		bean: false,
		cup: false,
		lime: false,
		bag: false,
		orange: false,
	}
	
	with obj_achievementController
		reset_level_stats()
}

function playerSounds()
{
	if state == states.tumble
	{
		fmod_studio_event_instance_set_paused(soundsRoll, false);
		if !FMODevent_isplaying(soundsRoll)
			fmod_studio_event_instance_start(soundsRoll);
		FMODSet3dPos(soundsRoll, x, y);
	}
	else{
		fmod_studio_event_instance_stop(soundsRoll, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
	}
	
	if state == states.hammerattack
	{
		var s = 0
		if abs(movespeed) > 0
			s = abs(movespeed) / 12
			
		fmod_studio_event_instance_set_paused(soundsHammer, false);
		if !FMODevent_isplaying(soundsHammer)
			fmod_studio_event_instance_start(soundsHammer);
		FMODSet3dPos(soundsHammer, x, y);
		
		if fmod_studio_event_instance_get_parameter_by_name(soundsHammer, "state") != s
			fmod_studio_event_instance_set_parameter_by_name(soundsHammer, "state", s)
	}
	else{
		fmod_studio_event_instance_stop(soundsHammer, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
	}
	
	if state == states.groundpoundstart || state == states.groundpound
	{
		fmod_studio_event_instance_set_paused(soundsGroundpound, false);
		if !FMODevent_isplaying(soundsGroundpound)
			fmod_studio_event_instance_start(soundsGroundpound);
		FMODSet3dPos(soundsGroundpound, x, y);
	}
	else{
		fmod_studio_event_instance_stop(soundsGroundpound, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
	}
	
	if sprite_index == spr_milton_dive
	{
		fmod_studio_event_instance_set_paused(soundsHammerAir, false);
		if !FMODevent_isplaying(soundsHammerAir)
			fmod_studio_event_instance_start(soundsHammerAir);
		FMODSet3dPos(soundsHammerAir, x, y);
	}
	else{
		fmod_studio_event_instance_stop(soundsHammerAir, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
	}
	
	if state == states.superjumpprep || sprite_index == spr_player_superjump
	{
		fmod_studio_event_instance_set_paused(soundsSuperjump, false);
		if !FMODevent_isplaying(soundsSuperjump)
			fmod_studio_event_instance_start(soundsSuperjump);
		FMODSet3dPos(soundsSuperjump, x, y);
		if sprite_index == spr_player_superjump
		{
			fmod_studio_event_instance_set_parameter_by_name(soundsSuperjump, "state", 1)
		}
		else {
			fmod_studio_event_instance_set_parameter_by_name(soundsSuperjump, "state", 0)
		}
	}
	else{
		fmod_studio_event_instance_stop(soundsSuperjump, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
	}
	
	if state == states.skateboardmove || state == states.skateboardwall
	{
		fmod_studio_event_instance_set_paused(soundsSkateboard, false);
		if !FMODevent_isplaying(soundsSkateboard)
			fmod_studio_event_instance_start(soundsSkateboard);
		FMODSet3dPos(soundsSkateboard, x, y);
	}
	else{
		fmod_studio_event_instance_stop(soundsSkateboard, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
	}
	
	if state == states.skateboardaim
	{
		fmod_studio_event_instance_set_paused(soundsSkateAim, false);
		if !FMODevent_isplaying(soundsSkateAim)
			fmod_studio_event_instance_start(soundsSkateAim);
		FMODSet3dPos(soundsSkateAim, x, y);
	}
	else{
		fmod_studio_event_instance_stop(soundsSkateAim, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
	}
	
	if state == states.mach2 || state == states.mach3 || state == states.climbwall
	{
		fmod_studio_event_instance_set_paused(soundsMach, false);
		if !FMODevent_isplaying(soundsMach)
			fmod_studio_event_instance_start(soundsMach);
		var s = 0;
		if state == states.mach2 && sprite_index == spr_player_mach1 && grounded
			s = 0;
		else if ((state == states.mach2 && sprite_index != spr_player_mach1) || state == states.climbwall)
			s = 1;
		else if state == states.mach3 && sprite_index != sprites.crazyrun
			s = 2;
		else if sprite_index == sprites.crazyrun
			s = 3
		FMODSet3dPos(soundsMach, x, y);
		if fmod_studio_event_instance_get_parameter_by_name(soundsMach, "state") != s
			fmod_studio_event_instance_set_parameter_by_name(soundsMach, "state", s)
	}
	else{
		fmod_studio_event_instance_stop(soundsMach, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
	}
}

function doGrab()
{
	var move = key_right + key_left
	
	if slapBuffer > 0
	{
		if character != characters.milton
		{
			
			if !key_up
			{
				fmod_studio_event_instance_start(soundGrab)
				FMODSet3dPos(soundGrab, x, y)
				slapBuffer = false
				state = states.grab
				sprite_index = spr_player_grab
				image_index = 0
				create_particleStatic(spr_grabcloud, x, y, xscale, 1)
				if movespeed < 8
					movespeed = 8
			}
			else {
				FMODevent_oneshot("event:/Sfx/Player/uppercut", x, y)
				slapBuffer = false
				vsp = -16
				if state == states.mach3 || sprite_index == spr_player_longjump || sprite_index == spr_player_longjumpend
					sprite_index = spr_player_mach_uppercut
				else
					sprite_index = spr_player_uppercut
				image_index = 0
				state = states.uppercut
				create_particleStatic(spr_jumpeffect, x, y, 1, 1)
				squashX = 1.5
				squashY = 0.6
			}
			
		}
		else
		{
			if move != 0
				xscale = move
			vsp = 0
			buffers.hammer = 25
			slapBuffer = false
			state = states.hammerattack
			create_particleStatic(spr_crazyrunothereffect, x, y, xscale, 1).image_speed = 0.5
			create_particleStatic(spr_grabcloud, x, y, xscale, 1)
			
			if movespeed < 12
				movespeed = 12
				
			image_index = 0
			sprite_index = spr_milton_hammerspin_prep
		}
		exit;
	}
}

function slope_momentum(_accel = 0.1, _accel2 = 0.2) {
	if !scr_slope(x, y + 1)
		exit;
	with (instance_place(x, y + 1, obj_slope))
	{
		if sign(image_xscale) != other.xscale
		{
			if abs(image_yscale) >= abs(image_xscale)
				other.movespeed += _accel2
			else
				other.movespeed += _accel
		}
	}
}

function doTaunt()
{
	if key_taunt_pressed
	{
		if instance_exists(obj_stayawake_mash)
		{
			with obj_stayawake_mash
			{
				shake = 15
				mashCount--
			}
			exit;
		}
		
		tauntVars = {
			sprite_index: sprite_index,
			image_index : image_index,
			state: state,
			vsp: vsp,
			hsp: hsp,
			movespeed: movespeed,
			image_speed: image_speed
		}
		
		tauntTimer = 20
		var _isSupertaunt = canSupertaunt && key_up
		if !_isSupertaunt
		{
			squashX = 1.1
			squashY = 1.1
			state = states.taunt
			image_speed = 0
			sprite_index = sprites.taunt
			image_index = irandom(image_number)
			instance_create(x, y, obj_taunteffect)
			instance_create(x, y, obj_parryhitbox)
			FMODevent_oneshot("event:/Sfx/Player/taunt", x, y)
		}
		else {
			state = states.taunt
			image_speed = 0.35
			sprite_index = choose(spr_player_supertaunt1, spr_player_supertaunt2, spr_player_supertaunt3, spr_player_supertaunt4)
			image_index = 0
			FMODevent_oneshot("event:/Sfx/Player/supertaunt", x, y)
			supertaunt = 0
			canSupertaunt = false
			var _speed = [[-20, 0], [-20, -20], [0, -20], [20, -20], [20, 0], [20, 20], [0, 20], [-20, 20]]
			var i = 0
			repeat(array_length(_speed))
			{
				with instance_create(x, y, obj_tauntafterimage)
				{
					hspeed = _speed[i][0]
					vspeed = _speed[i][1]
				}
				i++
			}
			instance_create(x, y, obj_taunteffect)
			with obj_baddie
			{
				if in_camera()
				{
					supertauntKill = true
					instance_destroy()
				}
			}
		}
		
		if instance_exists(obj_server)
		{
			with obj_server
				instance_create_online(other.x, other.y, other.depth + 2, obj_onlineTaunteffect)
		}
		
		if place_meeting(x, y, obj_exitgate) && global.escape.active && global.level != "tutorial"
		{
			if global.tauntcount < 10
			{
				global.tauntcount++
				create_collect(spr_taunteffect, x, y)
				global.collect += 25
				create_smalltext(25)
				FMODevent_oneshot("event:/Sfx/General/Collects/escapecollect", x, y)
			}
		}
		exit;
	}
}

function get_characterspr(character)
{
	var st = {
		player: {},
		tv: {}
	}
	
	switch character
	{
		case characters.mildred:
			st.player.idle = spr_player_idle
			st.player.taunt = spr_player_taunt
			st.player.mach3 = spr_player_mach3
			st.player.mach3hit = spr_player_mach3hit
			st.player.mach3jump = spr_player_mach3jump
			st.player.rolling = spr_player_rolling
			st.player.move = spr_player_move
			st.player.crazyrun = spr_player_crazyrun
			st.player.dive = spr_player_dive
			st.player.divebomb = spr_player_divebomb
			st.player.gateslam = spr_player_gateslam
			st.player.palette_colors = spr_playerPatColors
			st.player.player_pal = spr_playerPal
			//TV
			st.tv.idle = spr_tv_idle
			st.tv.mach3 = spr_tv_mach
			st.tv.crazyrun = spr_tv_crazyrun
			break
	}
	
	return(st)
}
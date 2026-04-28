var _max_channels = 1024
var _flags_core = FMOD_INIT.NORMAL;
var _flags_studio = FMOD_STUDIO_INIT.LIVEUPDATE;

#macro USE_FMOD_STUDIO true // Are we using FMOD studio (true) or just core (false)?
#macro USE_DEBUG_CALLBACKS false // Should debugging be initialised?

/* If we enable debug callbacks in the macro above set them ON */
if (USE_DEBUG_CALLBACKS)
{
    fmod_debug_initialize(FMOD_DEBUG_FLAGS.LEVEL_LOG, FMOD_DEBUG_MODE.CALLBACK);
}

/* If we want to use FMOD_STUDIO */
if (USE_FMOD_STUDIO)
{
	/*
		If you are only using Studio you need this.
        It creates the Studio System and prints its result to the Output Log.
        It then initialises the system with the previously set variables, printing the result of that function.

        The FMOD Studio System function also initialises the core FMOD system, which is why you do not need to call fmod_system_create() here.
	*/
	fmod_studio_system_create();
	show_debug_message("fmod_studio_system_create: " + string(fmod_last_result()));

	fmod_studio_system_init(_max_channels, _flags_studio, _flags_core);
	show_debug_message("fmod_studio_system_init: " + string(fmod_last_result()));

	/*
		FMOD Studio will create an initialize an underlying core system to work with.
	*/
	fmod_main_system = fmod_studio_system_get_core_system();
}
// If we want to use FMOD Core only
else
{
	/*
		If you are only using Core you only need this.

        It creates and initialises the core FMOD system, printing the result of each call to the Output Log.
	*/
	fmod_main_system = fmod_system_create()
	show_debug_message("fmod_system_create: " + string(fmod_last_result()))

	fmod_system_init(_max_channels, _flags_core)
	show_debug_message("fmod_system_init: " + string(fmod_last_result()))
}
loadedBanks = []
var banks = ["sound/Desktop/Master.bank", "sound/Desktop/Master.strings.bank", "sound/Desktop/Music.bank", "sound/Desktop/Sfx.bank", "sound/Desktop/Ambience.bank"] // all your banks
for (var i = 0; i < array_length(banks); i++)
{
	var b = working_directory + banks[i]
	array_push(loadedBanks, fmod_studio_system_load_bank_file(b, FMOD_STUDIO_LOAD_BANK.NORMAL))
	show_debug_message($"Loaded {b}!")
}

ini_open(working_directory + "saveData.ini")
global.MasterVolume = ini_read_real("General", "Master", 1)
global.MusicVolume = ini_read_real("General", "Music", 1)
global.SfxVolume = ini_read_real("General", "Sfx", 0.8)
global.AmbianceVolume = ini_read_real("General", "Ambiance", 1)
ini_close()
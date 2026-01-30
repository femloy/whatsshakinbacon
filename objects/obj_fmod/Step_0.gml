if (USE_FMOD_STUDIO) {
	/*
		If you are only using Studio you need this.
        This call will update the STUDIO system and the underlying CORE system.
	*/
	fmod_studio_system_update();
}
else {
	/*
		If you are only using Core you only need this.
	*/
	fmod_system_update();
}
var _x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2;
var _y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2;
var _att = global.Fmod3dDefaults
_att.position = { x: _x, y: _y, z: 0}
fmod_studio_system_set_listener_attributes(0, _att)
fmod_studio_system_update();
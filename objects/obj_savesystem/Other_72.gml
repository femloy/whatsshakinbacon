var _id = async_load[? "id"];
var _stat = async_load[? "status"];

switch state
{
	case savesystem.saving:
		if _id == save_id
		{
			buffer_delete(save_buff)
			state = savesystem.idle
		}
		break
	case savesystem.loading:
		if _id == save_id
		{
			var buffstring = buffer_read(load_buff, buffer_string)
			ini_open_from_string(buffstring)
			ini_str = ini_close()
			buffer_delete(load_buff)
			state = savesystem.idle
		}
		break
}
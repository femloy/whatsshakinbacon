function send_data(_st)
{
	var _buff = buffer_create(12, buffer_grow, 1)
	buffer_seek(_buff, buffer_seek_start, 0)
	var q = json_stringify(_st, true)
	buffer_write(_buff, buffer_string, q)
	self.network_send_packetServ(_buff, buffer_tell(_buff))
	buffer_delete(_buff)	
}

function instance_create_online(x, y, depth, obj, _variables = {})
{
	var struct = {}
	
	struct.x = x
	struct.y = y
	struct.depth = depth
	struct.obj = obj
	struct.room = room
	struct.onlineID = onlineID	
	struct.type = asyncTypes.createObject
	struct.vars = _variables
	
	send_data(struct)
}
enum asyncTypes
{
	notif,
	playerUpdate,
	serverClose,
	addParticle,
	addAfterimage,
	deleteObject,
	createSound,
	modifyPlayers,
	sendConnections,
	createObject
}

randomize()
onlineID = irandom_range(0, 1000000)

notifs = ds_list_create()
connections = ds_list_create()
network_send_packetServ = function(_bufferId, _size) {
	if global.client == -4 for (var i = ds_list_size(connections); i--;)
		network_send_packet(connections[| i], _bufferId, _size)
	if global.server == -4
		network_send_packet(global.client, _bufferId, _size)
}

create_notifAsync = function(_text, _color)
{
	var p = {type: asyncTypes.notif, text: _text, color: _color, alpha: 1, gotime: 90},
		buff = buffer_create(32, buffer_grow, 1);
	buffer_write(buff, buffer_string, json_stringify(p)); 
	network_send_packetServ(buff, buffer_tell(buff)); buffer_delete(buff);
	ds_list_add(notifs, p);
}

playerInRoom = 0
var _playerBuff = buffer_create(1, buffer_grow, 32)
buffer_seek(_playerBuff, buffer_seek_start, 0);
global.playercount = ds_list_size(connections) + 1
var _socket = global.client
var _isServer = global.client == -4
if _isServer
	_socket = "server"
var _spr = obj_player.sprite_index
if global.username == "unboundedoceanofconsciousness"
	_spr = spr_mildredKart
var _struct = {
	type: asyncTypes.playerUpdate,
	x: obj_player.x,
	y: obj_player.y,
	room: room,
	socket: _socket,
	sprite_index: _spr,
	image_index: obj_player.image_index,
	xscale: obj_player.xscale,
	image_alpha: obj_player.image_alpha,
	image_blend: obj_player.image_blend,
	flash: obj_player.flash,
	state: obj_player.state,
	depth: obj_player.depth,
	spr_palette: obj_player.sprites.player_pal,
	spr_pattern: global.patternSpr,
	palIndex: obj_player.palette_index,
	name: global.username,
	breakdanceheld: obj_player.buffers.breakdanceheld,
	breakdancespeed: obj_player.breakdancespeed,
    onlineID: onlineID
}
var q = json_stringify(_struct, true)
buffer_write(_playerBuff, buffer_string, q);
self.network_send_packetServ(_playerBuff, buffer_tell(_playerBuff))
buffer_delete(_playerBuff)

/*
if _isServer
{
	var _conBuff = buffer_create(12, buffer_grow, 1)
	buffer_seek(_conBuff, buffer_seek_start, 0)
	var _sampleArr = []
	if !ds_list_empty(connections)
	{
		for (var i = 0; i < ds_list_size(connections); i++)
		{
			array_push(_sampleArr, connections[| i])
		}
	}
	var _st = {type: asyncTypes.sendConnections, con: _sampleArr}
	var q = json_stringify(_st, true)
	buffer_write(_conBuff, buffer_string, q)
	self.network_send_packetServ(_conBuff, buffer_tell(_conBuff))
	buffer_delete(_conBuff)
}
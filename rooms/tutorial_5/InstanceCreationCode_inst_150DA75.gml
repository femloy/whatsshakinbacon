totem = 0
ini_open(global.saveFile)
var isCollected = ini_read_real("General", $"Totem{totem}", false)
ini_close()

if isCollected
	instance_destroy()
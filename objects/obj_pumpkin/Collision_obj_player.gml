instance_destroy()
global.pumpkins.count++
create_particleStatic(spr_genericpoofeffect, x, y, 1, -60)
scr_transfotip($"[wave]There are {global.pumpkins.amount - global.pumpkins.count} Pumpkins Left...")
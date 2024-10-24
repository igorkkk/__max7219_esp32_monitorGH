if wth.banja and wth.banja > 39 then return (function() askfl 'prtBanja.lua' end)() end
if not dat.prt then dat.prt = 1 end
local t = {
    {'_getnow.lua', 900, 0},
    {'_getdayandnight.lua', 900, 0},
    {'_narodask.lua', 300, 0},
    {'askds18b20.lua', 180, 0},
    {"mqttpub.lua", 60, 0}
}
local now = (rtctime.get())
print() print() 
print('now', now, t[dat.prt][3], t[dat.prt][2], t[dat.prt][1] )

if now - t[dat.prt][3] > t[dat.prt][2] then
    askfl(t[dat.prt][1])
    t[dat.prt][3] = now
    print('t[dat.prt][3] :', t[dat.prt][3])
    print('Set'..t[dat.prt][1]..' at '.. t[dat.prt][3] )
end
dat.prt = (dat.prt == #t) and 1 or (dat.prt + 1) 
local t, e
local i = 4
local a = 22
mdig = {}
local o = { {}, {}, {}, {}, {}, {}, {}, {} }
dofile('dstart.lua')
for e = 1, 8 do
    for t = 1, 4 do table.insert(o[e], mdig[t][e]) end
    max7219.sLine(e, o[e])
end
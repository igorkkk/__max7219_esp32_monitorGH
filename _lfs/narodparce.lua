print('Parce Narod')
local i, n
local a, o = 0, 0
local t = 100
local h = dat.sens
local e = function(...)
    for t, e in ipairs({ ... }) do
        if t % 2 == 1 then
            n = e
        else
            dat.sensnar[n] = tonumber(e) or 100
        end
    end
    for _, e in ipairs(h) do
        if dat.sensnar['' .. e] then
            print('d' .. e, dat.sensnar['' .. e])
            if dat.sensnar['' .. e] < t then t = dat.sensnar['' .. e] end
        end
    end
    print('Narod Min:', t)
    if t ~= 100 then
        wth.narod = tonumber(string.format("%.1f", t))
    else
        print('Lost Nrod')
        wth.narod = nil
    end
end
while true do
    if not c then break end
    o = string.find(c, 'id', o + 2)
    if not o then break end
    a = a + 1
end
if a > 0 then
    i = string.rep('.-id":(%d+).-value":([+-]*%d+%.*%d*)', a)
    e(string.match(c, i))
else
    print('Lost narod')
end
_G.c = nil
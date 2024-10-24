do
local a = dat.uuid
local t = dat.api_key
local e = dat.sens[dat.pnarod]
local l = #dat.sens
if not a or not t or not e then
    print('Not dat.uuid or dat.api_key')
    return
else
    local srv = net.createConnection(net.TCP, 0)
    local o = function(t, u)
        _G.c = u
        t:close()
        t = nil
        srv = nil
        parce = nil
        askfl'narodparce.lua'
    end
    dat.pnarod = dat.pnarod >= l and 1 or dat.pnarod + 1
    prt('ask sensor', 'd' .. e)
    srv:on("receive", o)
    srv:on("connection", function(f, i)
        f:send("GET /api/sensorsValues?sensors=" ..
            e ..
            "&uuid=" ..
            a ..
            "&api_key=" ..
            t .. "&lang=en HTTP/1.1\r\nUser-Agent: Mozilla/5.0\r\nHost: narodmon.ru\r\nConnection: close\r\n\r\n")
    end)
    srv:connect(80, "narodmon.ru")
end
end
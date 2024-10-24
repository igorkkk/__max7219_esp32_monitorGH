if not prt then prt = print end
print('Works Get Forecast OM!')
local con, killt, conclose, makedt, rq, make
local _up_thsh = 3
local _skip_hd = true
local _cnt = 0
local i, j
local answer = ''
local answtb
local t = 100

if not wth then wth = {} end
if not dat then dat = {} end
if not dat.lat then
    dat.lat = '55.7522'
    dat.lon = '37.6156'
end
prt('Coordinates: ' .. dat.lat .. ' ; ' .. dat.lon)

make = function(...)
    local tb = { ... }
    for k = 1, #tb do
        tb[k] = tonumber(tb[k]) or 100
    end
    return tb
end

rq = "GET https://api.open-meteo.com/v1/forecast?latitude=" ..
    dat.lat ..
    "&longitude=" ..
    dat.lon ..
    "&hourly=temperature_2m,weather_code&timezone=Europe%2FMoscow&temporal_resolution=hourly_6&forecast_days=1&forecast_hours=24 HTTP/1.1\r\n" ..
    "Host: api.open-meteo.com\r\n"

conclose = function(conn)
    prt('Closing connection!')
    pcall(function() conn:close() end)
    conn = nil; con = nil
    makedt(answer)
end
makedt = function(str)
    -- prt(str)
    answtb = make(string.match(str,
         '"temperature_2m":%[(%p*%d+%.-%d*),(%p*%d+%.-%d*),(%p*%d+%.-%d*),(%p*%d+%.-%d*)%].*code":%[(%p*%d+%.-%d*),(%p*%d+%.-%d*),(%p*%d+%.-%d*),(%p*%d+%.-%d*)%]'))
    prt(answtb[1], answtb[2], answtb[3], answtb[4], answtb[5], answtb[6], answtb[7], answtb[8])
    

    prt('\t\t\t\t\t\t\t\t\t tm[hour]:', tm["hour"])
    
    if tm["hour"] > 22 or (tm["hour"] > 0 and tm["hour"] < 16) then
        t = -100
        for k = 1, 4 do
                if answtb[k] > t then t = answtb[k] end
        end
    else
        t = 100
        for k = 1, 4 do
                if answtb[k] < t then t = answtb[k] end
        end
    end

    prt(t)
    wth.tempFCOM = tonumber(t)
    t = 0
    for k = 5, 8 do
        if answtb[k] > t then t = answtb[k] end
    end
    prt(t)
    wth.codeFCOM = tonumber(t)
end

local function data_received(c, data)
    if _skip_hd then
        i, j = string.find(data, '\r\n\r\n')
        if i then
            _skip_hd = false
            data = string.sub(data, j + 1, -1)
        end
    end

    if not _skip_hd then
        _cnt = _cnt + 1
        answer = answer .. data
        if _cnt > _up_thsh then
            conclose(c)
        end
    end
end

if dat.ip then
    killt = tmr.create()
    killt:alarm(2000, 0, function(t)
        if con then
            conclose(con); prt('\n\nConn killed!\n\n')
        end
        t:stop(); t:unregister(); t = nil; killt = nil
    end)
    con = net.createConnection(net.TCP, 0)
    con:on("connection", function(con, t) con:send(rq .. "Connection: close\r\nAccept: /\r\n\r\n") end)
    con:on("disconnection", conclose)
    con:on("receive", data_received)
    con:connect(80, 'api.open-meteo.com')
end
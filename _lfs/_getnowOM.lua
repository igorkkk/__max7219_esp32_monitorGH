if not prt then prt = print end
prt('Works Getnow OM!')
local offset, temp, day, code, wind, humy, rain
local con, killt, conclose, makedt, rq
local _up_thsh = 3
local _skip_hd = true
local _cnt = 0
local i, j
local answer = ''

if not wth then wth = {} end
if not dat then dat = {} end
if not dat.lat then
    dat.lat = '55.7522'
    dat.lon = '37.6156'
end
prt('Coordinates: ' .. dat.lat .. ' ; ' .. dat.lon)

rq = "GET https://api.open-meteo.com/v1/forecast?latitude=" ..
    dat.lat ..
    "&longitude=" ..
    dat.lon ..
    "&current=temperature_2m,relative_humidity_2m,is_day,rain,weather_code,wind_speed_10m&timezone=auto&forecast_days=1 HTTP/1.1\r\n" ..
    "Host: api.open-meteo.com\r\n"

conclose = function(conn)
    prt('Closing connection!')
    pcall(function() conn:close() end)
    conn = nil; con = nil
    makedt(answer)
end
makedt = function(str)
    -- prt(str)
    offset, temp, humy, day, rain, code, wind = string.match(str,
        '_seconds":(%d*),.*ture_2m":(%p*%d+%.-%d*),.*ity_2m":(%d*),.+_day":(%d),.*"rain":(%d+%.-%d*),.+_code":(%d+),.*_10m":(%d+%.-%d*)}')
    prt(offset, temp, humy, day, rain, code, wind)
    if offset then wth.offset = tonumber(offset) end
    if temp then wth.tempOM = tonumber(temp) end
    if humy then wth.humy = humy end
    if day then wth.day = tonumber(day) end
    if rain then wth.rain = rain end
    if code then wth.code = tonumber(code) end
    if wind then wth.wind = tonumber(wind) end
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
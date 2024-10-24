-- !!!!! Works !!!!
-- setup
if not dat then dat = {} end
if not wth then wth = {} end
if not dat.wkey then dat.wkey = "wkeywkeywkeywkeywkeywkeywkey" end
if not wth.city then wth.city = 'Moscow' end

print('Works Getnow!')
if not dat.wkey then return end
print('city:' .. wth.city)
local e, t
local i = true
local a = ''
local nowt, d, o, h, timezone
local l = "GET http://api.openweathermap.org/data/2.5/weather?q=" ..
    -- wth.city .. "&mode=xml&units=metric&appid=" .. dat.wkey .. " HTTP/1.1\r\n" ..
    wth.city .. "&units=metric&appid=" .. dat.wkey .. " HTTP/1.1\r\n" ..
    "Host: api.openweathermap.org\r\n"
o = function(t)
    pcall(function() e:close() end)
    t, e = nil, nil
end
h = function(h, e)
    if e then print('\t\t\t\t\t\tGot Answer!') end
    -- print(e)
    
    if t then t:stop(); t:unregister(); t = nil end
    if i then
        a = a .. e
        -- local o, t = string.find(a, '?>')
        local o, t = string.find(a, 'coord')
        if o then
            i = false
            e = string.sub(a, t + 1, -1)
            a = nil
        end
    end
    if not i then
        -- local timezone, nowt, hum, press, wind, d  =  string.match(e,  'timezone>(%d+)<.*temperature value="(%p*%d+%.-%d*)".*humidity value="(%d+).*pressure value="(%d+)".*speed value="(%d+%.-%d*)".*weather number="(%d+)"' )
        local d, nowt, press, hum, wind, timezone = string.match(e,  '"weather":%[{"id":(%d+).*"main":{"temp":(%p*%d+%.-%d*),.*"pressure":(%d+),.*"humidity":(%d+),.*"speed":(%d+%.-%d*),.*"timezone":(%d+),')
        print(d, nowt, press, hum, wind, timezone)
        print('timezone:', timezone)
        if timezone then timezone = (timezone / 3600) 
        else timezone = wth.tz end
        print('timezone at hour:', timezone)
        dat.tz = timezone
        wth.tz = timezone
        wth.avgnow = nowt
        wth.codenow = tonumber(d)
        wth.hum = hum
        wth.press = press
        wth.wind = wind

        print('tempnow:', wth.avgnow)
        print('codenow:', wth.codenow)
        o(h)
    end
end
if dat.ip then
            wth.avgnow = nil
            wth.codenow = nil
            t = tmr.create()
            t:alarm(2000, 0, function(t)
                if e then
                    o()
                    print('\n\nConn killed!\n\n')
                end
            end)
            e = net.createConnection(net.TCP, 0)
            e:on("connection", function(e, t) e:send(l .. "Connection: close\r\nAccept: /\r\n\r\n") end)
            e:on("disconnection", o)
            e:on("receive", h)
            e:connect(80, 'api.openweathermap.org')
        else
            print('\n\t\t\tLost WiFi!')
end
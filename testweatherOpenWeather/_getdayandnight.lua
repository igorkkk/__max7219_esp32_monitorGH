--- Works!!!

-- setup
if not dat then dat = {} end
if not wth then wth = {} end
if not dat.wkey then dat.wkey = "wkeywkeywkeywkeywkeywkeywkey" end
if not wth.city then wth.city = 'Moscow' end
tm = time.getlocal()

if not dat.wkey then return end
print('city:' .. wth.city)
local m = '6'
local e, h, c, u
local r = true
local t = ""
local s = "T15"
-- local s = "15:00:00"
local d = false
local i, o, l, a
local n = tm.hour
print('\n\t\t\thour now:', n)
if n >= 15 and n <= 21 then s = "T03" end
-- if n >= 15 and n <= 21 then s = "03:00:00" end
h = function(t)
    if a then
        a:stop();
        a:unregister();
        a = nil
    end
    if e then
        pcall(function() e:close() end)
        e = nil
    end
    t = nil
end
c = function(n, e)
    if e then print('Got data!') end
    if r then
        t = t .. e
        local o, a = string.find(t, s)
        if o then
            r = false
            e = string.sub(t, a + 1, -1)
            t = e
        else
            t = ""
        end
    end
    if not r then
        if d then t = t .. e end
        i, o = string.match(t, ':00"><symbol number="(%d+).*s" value="(%p*%d+%p*%d*)')
        
        if i and o then
            print('\n\t\t\tGot Data to Time' .. s .. ':00')
            print('\t\t\tGot Code:', i, o)
            wth.codef = tonumber(i)
            wth.avgtf = o
            
            h(n)
        else
            d = true
        end
    end
end
u = function()
    print("Disconnected")
end
l = "GET http://api.openweathermap.org/data/2.5/forecast?q=" ..
    wth.city .. "&mode=xml&units=metric&cnt=" .. m .. "&appid=" .. dat.wkey .. " HTTP/1.1\r\n" ..
    -- wth.city .. "&units=metric&cnt=" .. m .. "&appid=" .. dat.wkey .. " HTTP/1.1\r\n" ..
    "Host: api.openweathermap.org\r\n"
if dat.ip then
            wth.codef = nil
            wth.avgtf = nil
            a = tmr.create()
            a:alarm(2000, 0, function(t)
                if e then
                    h(e)
                    print('\n\nConn killed!\n\n')
                end
            end)
            e = net.createConnection(net.TCP, 0)
            e:on("connection", function(e, t) e:send(l .. "Connection: close\r\nAccept: /\r\n\r\n") end)
            e:on("receive", c)
            e:on("disconnection", u)
            e:connect(80, 'api.openweathermap.org')
end
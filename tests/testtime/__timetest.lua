

-- net.dns.resolve("ntp1.ntp-servers.net", function(ip)
--     if ip then
--       print('sec = ', (time.get()))
--     end
--   end)
   


dat = {}
SSID = 'SSID'
PASSWD = 'passwd'

time.settimezone('EST-3')
-- time.initntp()
-- time.initntp("pool.ntp.org")

wifi.start()
wifi.mode(wifi.STATION, true)

wifi.sta.on("disconnected", function(ev, info)
    print("Lost WiFi!")
    dat.wifi = nil
    dat.ip = nil
    time.ntpstop()
    wifi.sta.connect()
end)
wifi.sta.on("got_ip", function(ev, info)
    dat.wifi = true
    dat.ip = info.ip
    print("NodeMCU Got IP:", info.ip)
    time.initntp("pool.ntp.org")

end)

local scfg = {}
scfg.auto = true
scfg.save = true
scfg.ssid = SSID
scfg.pwd = PASSWD
SSID, PASSWD = nil, nil

wifi.sta.config(scfg, true)
wifi.sta.connect()


asktime = function ()
    local nowt, nowts = time.get()
    print(string.format('%d %d', nowt, nowts))
    localTime = time.getlocal()
    print(string.format("%04d-%02d-%02d %02d:%02d:%02d DST:%d", localTime["year"], localTime["mon"], localTime["day"], localTime["hour"], localTime["min"], localTime["sec"], localTime["dst"]))
    local rev =  time.cal2epoch(localTime)
    print(string.format('rev:  %d', rev))

end

tmr.create():alarm(2000, 1, asktime)
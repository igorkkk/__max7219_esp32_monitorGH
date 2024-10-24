
SSID = 'SSID'
PASSWD = 'passwd'

if not dat then dat = {} end
if not wth then wth = {} end

TIMEZONE = 'EST-3'
time.settimezone(TIMEZONE)
TIMEZONE = nil

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
    time.initntp()
end)

local scfg = {}
scfg.auto = true
scfg.save = true
scfg.ssid = SSID
scfg.pwd = PASSWD
SSID, PASSWD = nil, nil

wifi.sta.config(scfg, true)
wifi.sta.connect()

local fi=node.LFS.get; pcall(fi and fi'_init')
dat = {}
wth = {}

TIMEZONE = 'EST-3'

dofile'_setuser.lua'
-- dofile('_testDS18b20.lua')

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
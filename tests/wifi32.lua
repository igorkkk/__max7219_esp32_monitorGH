do
    wifi.start()
    wifi.mode(wifi.STATION)
    wifi.sta.on("got_ip", function(ev, info) print("NodeMCU Got IP:", info.ip) end)
    time.settimezone('EST-3')
    time.initntp()
    local scfg = {}
    scfg.auto = true
    scfg.save = true
    scfg.ssid = 'SSID'
    scfg.pwd = 'passed'
    wifi.sta.config(scfg, true)
    wifi.sta.connect()
end

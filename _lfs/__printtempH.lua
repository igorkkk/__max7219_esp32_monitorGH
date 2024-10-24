do
    local t
    if wth.ds18b20 or wth.mqttint then
        t = wth.mqttint or wth.ds18b20
        t = string.format('H%0.1f', t)
        dat.notime = true
        OUT(t)
    end
end
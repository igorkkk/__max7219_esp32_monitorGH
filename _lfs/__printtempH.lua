do
    local t
    if wth.ds18b20 or wth.mqttint or wth.temp_scd30 then
        t = wth.mqttint or wth.ds18b20 or wth.temp_scd30 
        t = string.format('H%0.1f',  tonumber(t))
        dat.notime = true
        OUT(t)
    end
end
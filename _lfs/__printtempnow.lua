if wth.narod or wth.tempOM or wth.mqttoutt then
    local tmp = wth.mqttoutt or wth.narod or wth.tempOM
    if tmp == 0 then tmp = '0.0' else
    tmp = tmp > 0 and ('+'..tmp) or (''..tmp) end
    dat.notime = true
    OUT(tmp)
end
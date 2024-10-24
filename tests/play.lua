if dat.shownight or not dat.night then
    local e = 2000
    if wth.narod or wth.avgnow or wth.mqtttemp then
        tik:stop()
        if dat.anm then
            dat.call = maketemp
            if dat.askw % 6 == 0 then
                e = 3000
                askfl('moveupcall.lua')
            elseif dat.askw % 3 == 0 then
                e = 3000
                askfl('moveleftcall.lua')
            else
                dat.call = nil
                maketemp()
            end
        else
            maketemp()
        end
    end

    tmr.create():alarm(e, 0, function(e)
        e = nil
        if wth.codef and wth.codef > 99 and wth.codef < 1283 then
            askfl('prtForecast.lua')
        else
            askfl('prtHome.lua')
        end
    end)
end

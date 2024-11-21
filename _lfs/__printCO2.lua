do
    prt('\t\t\t\t\t\t\t!!!Work CO2:', wth.co2)
    dat.notime = true
    dofile 'dco2.lua'
    tmr.create():alarm(1500, tmr.ALARM_AUTO,
        function(t)
            t:stop(); t:unregister(); t = nil
            OUT('C' .. wth.co2)
        end
    )
end

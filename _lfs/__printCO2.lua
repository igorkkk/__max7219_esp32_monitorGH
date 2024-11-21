do
<<<<<<< HEAD
    prt('\t\t\t\t\t\t\t!!!Work CO2:', wth.co2)
    dat.notime = true
    dofile 'dco2.lua'
    tmr.create():alarm(1500, tmr.ALARM_AUTO,
        function(t)
            t:stop(); t:unregister(); t = nil
            OUT('C' .. wth.co2)
        end
    )
=======
    prt('\t\t\t\t\t\t\t!!!Work CO2:' , wth.co2 )
   -- if wth.co2 and wth.co2 > 1500 then
        dat.notime = true
        dofile'dco2.lua'
        tmr.create():alarm(1500, tmr.ALARM_AUTO, 
        function (t)
                t:stop(); t:unregister(); t = nil
                OUT('C' .. wth.co2)
            end
        )
    --else
      --  dofile'__printtime.lua'
    -- end
>>>>>>> ddfac53bba2a3e7e9adafee4324f58c78d9d4837
end

do
    local pm = 0
    prt('\n\n\t\t\t\t\t\t\t!!!work pm2_5', wth.pm2_5)
    --if wth.pm2_5 and tonumber(wth.pm2_5) > 25 then
        dat.notime = true
        dofile'dpm2_5.lua'
        pm = tonumber(wth.pm2_5)
        if pm > 99 then pm = math.floor(pm) end
        tmr.create():alarm(1500, tmr.ALARM_AUTO, 
        function (t)
                t:stop(); t:unregister(); t = nil
                OUT('pm' .. pm)
            end
        )
    --else
    --    dofile'__printtime.lua'
    --end
end

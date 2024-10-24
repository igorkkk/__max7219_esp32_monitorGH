do
    local blink = tmr.create()
    local dots = true
    local ln4 = ''
    local ln6 = ''
    local changedots = function(t)
        if dots == true then
            dots = false
            max7219.bToDig(ln4, 4)
            max7219.bToDig(ln6, 6)
        else
            dots = true
            max7219.bToDig(SOUTLINES[4], 4)
            max7219.bToDig(SOUTLINES[6], 6)
        end
    end

    blink:register(1000, tmr.ALARM_AUTO, changedots)

    local startblink = function()
        if not SOUTLINES then
            print '\t\t\\!!! Not Data To Blink!'; return
        end
        dots = true
        ln4 = string.sub(SOUTLINES[4], 1, 15) .. '0' .. string.sub(SOUTLINES[4], 17)
        ln6 = string.sub(SOUTLINES[6], 1, 15) .. '0' .. string.sub(SOUTLINES[6], 17)
        blink:start()
    end
    local stopblink = function()
        blink:stop()
        max7219.bToDig(SOUTLINES[4], 4)
        max7219.bToDig(SOUTLINES[6], 6)
    end

    STARTBLINK = startblink
    STOPBLINK = stopblink
end

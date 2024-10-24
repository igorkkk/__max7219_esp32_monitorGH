do
    if not digl then dofile '_digl.lua' end
    if not dat then dat = {} end
    local soutlines = {}
    local dt = 0
    local out, prtdt
    ------------------- Blink ------------------------------------------
    local blink = tmr.create()
    local dots = true
    local ln4 = ''
    local ln6 = ''
    dat.TMRWORK = false
    local changedots = function(t)
        if dots == true then
            dots = false
            max7219.bToDig(ln4, 4)
            max7219.bToDig(ln6, 6)
        else
            dots = true
            max7219.bToDig(soutlines[4], 4)
            max7219.bToDig(soutlines[6], 6)
        end
    end

    blink:register(1000, tmr.ALARM_AUTO, changedots)

    local startblink = function()
        dat.TMRWORK = true
        if not soutlines then
            print '\t\t\\!!! Not Data To Blink!'; return
        end
        dots = true
        ln4 = string.sub(soutlines[4], 1, 15) .. '0' .. string.sub(soutlines[4], 17)
        ln6 = string.sub(soutlines[6], 1, 15) .. '0' .. string.sub(soutlines[6], 17)
        blink:start()
    end
    local stopblink = function()
        dat.TMRWORK = false
        blink:stop()
        max7219.bToDig(soutlines[4], 4)
        max7219.bToDig(soutlines[6], 6)
    end
    -------------------------------------------------------------------
    prtdt = function(s)
        for k = 1, 8 do
            soutlines[k] = ''
            for i = 1, #s do
                soutlines[k] = soutlines[k] .. '0' .. digl[string.sub(s, i, i)][k]
                if string.sub(s, i, i) == ':' then
                    dt = #soutlines[k]
                end
            end
            if dt ~= 0 then
                soutlines[k] = string.rep('0', 16 - dt) .. soutlines[k]
                dt = #soutlines[k]
                soutlines[k] = soutlines[k] .. string.rep('0', 32 - dt)
            else
                soutlines[k] = string.sub(soutlines[k], 2)
                while #soutlines[k] < 32 do
                    soutlines[k] = '0' .. soutlines[k] .. '0'
                end
                if #soutlines[k] > 32 then soutlines[k] = string.sub(soutlines[k], 1, 32) end
            end
        end
    end

    out = function(s)
        prtdt(s)
        if dat.TMRWORK == true then stopblink() end
        -- max7219.clear()
        for i = 1, 8 do
            max7219.bToDig(soutlines[i], i)
        end
        if dt ~= 0 then
            dt = 0
            if dat.TMRWORK == false then startblink() end
        end
    end
    STOPBLINK = stopblink
    SOUTLINES = soutlines
    OUT = out
end

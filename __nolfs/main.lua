do
    local prt = print
    local minnow = 0
    local wt = {}
    local nowt
    local outtime = ''
    local tiktak, dispatch
    local counter = 0
    local printtime
    tm = time.epoch2cal((time.get()) + wth.offset)

    wt[1] = { '_getnowOM.lua', 900, 0 }
    wt[2] = { '_getForecastOM.lua', 900, 0 }
    wt[3] = { '_narodtric.lua', 600, 0 }
    wt[4] = { '__askMHZ19.lua', 300, 0 }
    wt[5] = { '_narodask.lua', 180, 0 }
    -- wt[6] = { '__askSDC41.lua', 60, 0 }
    wt[6] = { '__askds18b20.lua', 60, 0 }
    wt[7] = { 'mqttpub.lua', 30, 0 }
    wt[8] = { 'bright.lua', 17, 0 }

    local wts = {}
    wts[1] = {}

    printtime = function()
        if dat.notime then return end
        if not wth.offset then wth.offset = 10800 end
        tm = time.epoch2cal((time.get()) + wth.offset)
        local gethournow = tm["hour"]
        local getminnow = tm["min"]
        if getminnow ~= minnow and tm["year"] ~= 1970 then
            outtime = '' .. gethournow .. ':'
            outtime = getminnow > 9 and (outtime .. getminnow) or (outtime .. '0' .. getminnow)
            prt('OUT:', outtime)
            OUT(outtime)
            minnow = getminnow
        end
    end


    -- nowt = time.get()
    -- prt('Got Unix', nowt)
    tiktak = function()
        printtime()
        if not dat.shownight and dat.night then return end
        counter = counter + 1
        if counter == 8 then
            if wth.tempout or wth.narod or wth.tempOM then
                dofile '__printtempnow.lua'
            else
                counter = 11
            end
        end
        if counter == 11 then
            if wth.tempFCOM then
                dofile '__printtempFC.lua'
            else
                counter = 14
            end
        end

        if counter == 14 then
            if wth.tempFCOM then
                dofile '__printcodeFC.lua'
            else
                counter = 17
            end
        end

        if counter == 17 then
            if wth.ds18b20 and (wth.ds18b20 < 24 or wth.ds18b20 > 26.8) then
                dofile '__printtempH.lua'
            else
                counter = 20
            end
        end
        if counter == 20 then
            if wth.co2 and wth.co2 > 1500 then
                dofile '__printCO2.lua'
            else
                counter = 23
            end
        end
        if counter == 23 then
            if wth.pm2_5 and tonumber(wth.pm2_5) > 25 then
                dofile '__printPM2_5.lua'
            else
                counter = 27
            end
        end
        if counter > 26 then
            minnow = 61; dat.notime = false; counter = 1
        end
    end

    dispatch = function()
        local bright 
        if dat.lsens then
            wth.lux = 4095 - adc.read(adc.ADC1, dat.adcpin)
            -- if wth.lux <= wth.maxlux then
                bright = math.floor((dat.maxbright / (wth.maxlux - wth.minlux)) * (wth.lux - wth.minlux))
                bright = bright < 0 and 0 or bright
            -- end
            if bright ~= wth.bright then
                wth.bright = bright
                max7219.setIntensity(bright)
            end
        end
        nowt = (time.get())
        tiktak()
        if (not dat.ip) or (nowt % 3 ~= 0) then return end
        for k, v in pairs(wt) do
            --
            if nowt - v[2] > v[3] then
                v[3] = nowt
                print('\n\n\t\t\t\t\t\t', v[1], v[2], v[3])
                askfl(v[1])
                break
            end
        end
    end

    tik = tmr.create()
    tik:alarm(1000, 1, dispatch)
end

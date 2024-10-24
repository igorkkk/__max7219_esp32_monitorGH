tiktak = function()
    printtime()
    if not dat.shownight and wth.lux - wth.minlux < 50 then return end
    counter = counter + 1
    if counter == 8 then 
        if wth.tempout or wth.narod or wth.tempOM then dofile '__printtempnow.lua'
        else counter = 11 end
    end
    if counter == 11 then 
        if wth.tempFCOM then dofile '__printtempFC.lua' 
        else counter = 14 end    
    end

    if counter == 14 then 
        if wth.tempFCOM then dofile '__printcodeFC.lua' 
        else counter = 17 end
    end
    
    if counter == 17 then
        if wth.ds18b20 and (wth.ds18b20 < 24 or wth.ds18b20 > 26.8) then dofile '__printtempH.lua'
        else counter = 20 end
    end
    if counter == 20 then
        if wth.co2 and wth.co2 > 1500 then dofile '__printCO2.lua'
        else counter = 23 end
    end
    if counter == 23 then
        if wth.pm2_5 and tonumber(wth.pm2_5) > 25 then dofile '__printPM2_5.lua'
        else counter = 27 end
    end
    if counter > 26 then minnow = 61; dat.notime = false; counter = 1 end
end

local bright
local prt = prt or print


-- Определяем освещенность и запоминаем крайние значения
if dat.lsens then
    wth.lux = 4095 - adc.read(adc.ADC1, dat.adcpin)
    if wth.lux > wth.maxlux then wth.maxlux = wth.lux end
    if wth.lux < wth.minlux then wth.minlux = wth.lux end
    prt("\n\t\t\t\t\t\t\t\tGot Lux:", wth.lux)
end

-- -- Определяем день сейчас или ночь
if tm.hour >= dat.morn and tm.hour < dat.even then
    dat.night = false
else
    dat.night = true
end

if dat.night and dat.lsens and wth.lux then
    if wth.lux - wth.minlux < 100 then
        dat.night = true
    else
        dat.night = false
    end
end


-- Определяем необходимую яркость часов
-- Если нет датчика
if not dat.lsens then
    if dat.night then
        bright = 0
    else
        bright = dat.maxbright
    end

    -- Если есть датчик яркость устанавливается в main.lua
    -- else
    --     if wth.lux < wth.maxlux then
    --         bright = math.floor((dat.maxbright / (wth.maxlux - wth.minlux)) * (wth.lux - wth.minlux)) -- system
    --         bright = bright < 0 and 0 or bright
    --     else
    --         bright = dat.maxbright
    --     end

    -- Устанавливаем яркость
    if bright ~= wth.bright then
        wth.bright = bright
        max7219.setIntensity(bright)
        prt("Set Bright:", wth.bright)
    end
end

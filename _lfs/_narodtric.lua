do
    if not dat.nkey then return end
    prt('Work tric!')
    local montric = {}
    local makenew, tric, sendnarod

    makenew = function(data, k)
        if not data then return end
        data = tonumber(data) or 5000
        math.randomseed(math.floor(data))
        math.randomseed(math.random() * (time.get()))
        if data == 5000 then return end
        local dt
        local pm = 1
        if math.random() > 0.5 then pm = -1 end

        dt = data - data * k * pm * math.random()
        dt = string.format('%0.2f', dt)
        prt('Old:', data, 'New:', dt)
        return dt
    end

    tric = function()
        montric.temperature = makenew(wth.tempFCOM, 0.03)
        montric.hum = makenew(wth.humy, 0.03)
        -- montric.press = makenew(wth.press, 0.001)
        montric.wind = makenew(wth.wind, 0.4)
        montric.ds18b20 = wth.ds18b20

        prt('\n\nmontric table:')
        for k, v in pairs(montric) do prt(k, ':', v) end
        -- if montric.temperature and montric.hum and montric.press then
        if montric.temperature and montric.hum and montric.wind then
            sendnarod()
        end
    end

    sendnarod = function()
        prt('Do special To Send Narod')
        -- return
        narod = require('narodmonmod')
        prt("Send to Narod Now!")

        narod.sendNarod(dat.nkey, montric, function()
            narod = nil
            package.loaded["narodmonmod"] = nil
            collectgarbage()
        end)
    end
    tric()
end

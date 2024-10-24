function makett() -- Выбираем температуру
    local t = 100
    local e = {}
    wth.maintemp = nil
    if wth.narod then e[#e + 1] = tonumber(wth.narod) end
    if not wth.narod and wth.avgnow then e[#e + 1] = tonumber(wth.avgnow) end
    if wth.mqtttemp then e[#e + 1] = tonumber(wth.mqtttemp) end
    for a, e in ipairs(e) do
        if e < t then t = e end
    end
    if t ~= 100 then wth.maintemp = string.format("%.1f", t) end
    print('Narod:', wth.narod, 'OpenWeather:', wth.avgnow, 'MQTT:', wth.mqtttemp, '\n\t\t\tSet Now: ', wth.maintemp)
end

function printdata(i, a)
    print('data, sep', i, a)
    local o
    local e = {}
    local function n(a, t)
        for e = 1, 8 do
            a[e] = dig[t][e]
        end
    end
    for t = 1, 4 do
        o = string.sub(i, t, t)
        e[t] = {}
        n(e[t], o)
    end
    o = nil
    if a == ":" then
        if not dat.dotp then
            e[2][4] = e[2][4] + 1
            e[2][6] = e[2][6] + 1
            dat.dotp = true
        end
        dat.dot1 = e[2][4]
        dat.dot2 = e[2][6]
    end
    if a == '.' then  -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!
        -- e[3][8] = e[3][8] + 1
        -- e[2][8] = e[2][8] + 1
        e[4][1] = e[4][1] + 1
    end
    max7219.write(e)
    e, n = nil, nil
end

function maketemp(t, a)
    if not tonumber(t) then
        makett()
        t = wth.maintemp
        if not t then
            return
        else
            tik:stop()
        end
    end
    local o = string.find(t, "%.") or 0
    local e = string.sub(t, 1, o - 1)
    local t = o == 0 and '0' or string.sub(t, o + 1, o + 1) or '0'
    t = t == '' and '0' or t
    if string.sub(e, 1, 1) == '-' then
        if #e == 2 then e = '-0' .. string.sub(e, -1, -1) end
    else
        if a ~= 'H' then
            e = #e == 1 and '+0' .. e or '+' .. e
        end
    end
    if a then e = a .. e end
    if #e ~= 4 then e = e .. t end
    dat.mnow = e
    e, o, t = nil, nil, nil
    if not a or a == 'H' then
        printdata(dat.mnow, '.')
    else
        printdata(dat.mnow)
    end
end

askfl = function(t, e)
    if e then
        node.task.post(function() dofile(t)(e) end)
    else
        node.task.post(function() dofile(t) end)
    end
end
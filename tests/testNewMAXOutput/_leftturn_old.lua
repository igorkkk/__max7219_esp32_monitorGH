do
    local w = math.random(5)
    -- prt('\n\n\t\t\t\t\t\t\tw = ', w)
    if w > 2 or #SOUTLINES ~= 8 then
        if dat.call then dat.call() end
        return
    end
    STOPBLINK()
    local ln = ''
    local z = '0'
    local step = 1
    local tg = 33
    local move
    if w == 2 then
        tg = 9
    end
    move = function(i)
        for k = 1, 8 do
            if w == 1 then
                ln = string.sub(SOUTLINES[k], i)
                ln = ln .. (string.rep(z, i))
            else
                ln = SOUTLINES[k + i] or string.rep(z, 32)
            end
            max7219.bToDig(ln, k)
        end
    end
    tmr.create():alarm(30, 1, function(t)
        move(step)
        step = step + 1
        if step == tg then
            t:stop()
            t:unregister()
            t = nil
            if dat.call then dat.call() end
        end
    end)
end

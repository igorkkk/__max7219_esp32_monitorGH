do
    if #SOUTLINES ~= 8 then
        print 'Not Data To Move!'
        if dat.call then dat.call() end
        return
    end
    STOPBLINK()
    local ln = ''
    local z = '0'
    -- local step = 0
    local step = 1
    local function move(i)
        for k = 1, 8 do
            -- ln = SOUTLINES[k + 1 + i] or string.rep(z, 32)
            ln = SOUTLINES[k + i] or string.rep(z, 32)
            max7219.bToDig(ln, k)
        end
    end
    tmr.create():alarm(30, 1, function(t)
        move(step)
        step = step + 1
        -- if step == 8 then
        if step == 9 then
            t:stop()
            t:unregister()
            t = nil
            if dat.call then dat.call() end
        end
    end)
end

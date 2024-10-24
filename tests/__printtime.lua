do

    local prt = prt or print
    local outtime, tm, getminnow, printtime
    local minnow = 61
    if not dat.notime then return end 
    dat.notime = false
    printtime = function()
        tm = time.epoch2cal((time.get()) + (wth.offset or 10800))
        getminnow = tm["min"]
        if getminnow ~= minnow and tm["year"] ~= 1970 then
            outtime = '' .. tm["hour"] .. ':'
            outtime = getminnow > 9 and (outtime .. getminnow) or (outtime .. '0' .. getminnow)
            prt('OUT:', outtime)
            OUT(outtime)
            minnow = getminnow
        end
    end
    printtime()
    -- tmr.create():alarm(1000, 1, function(t)
    --     if dat.notime then
    --         t:stop(); t:unregister(); t = nil
    --     else
    --         printtime()
    --     end
    -- end)
end
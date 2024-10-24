do
    local tmp, str
    if wth.tempFCOM then
        tmp = tonumber(wth.tempFCOM)
        -- tmp = math.floor(tmp)
        if tmp <  10 and tmp > - 10 then
            str = string.format('%0.1f', tmp)
        else
            str = ''.. math.floor(tmp)
        end
        -- tmp = tmp > 0 and ('R+' .. tmp) or ('R' .. tmp)
        tmp = tmp > 0 and ('R+' .. str) or ('R' .. str)
        dat.notime = true
        OUT('' .. tmp)
    end
end
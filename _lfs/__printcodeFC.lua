do
    local filename = ''
    if wth.codeFCOM then
        if wth.codeFCOM < 3 then
            filename = 'dclearn.lua'
        elseif wth.codeFCOM == 3 then
            filename = 'dcloudn.lua'
        elseif wth.codeFCOM == 45 then
            filename = 'd45.lua'
        elseif wth.codeFCOM == 48 then
            filename = 'dfogn.lua'
        elseif wth.codeFCOM > 50 and wth.codeFCOM < 56 then
            filename = 'ddrizzlen.lua'
        elseif wth.codeFCOM == 57 or wth.codeFCOM == 58 then
            filename = 'ddrizzlesupern.lua'
        elseif wth.codeFCOM > 60 and wth.codeFCOM < 69 then
            filename = 'dreinn.lua'
        elseif wth.codeFCOM > 70 and wth.codeFCOM < 78 then
            filename = 'dsnown.lua'
        elseif wth.codeFCOM > 79 and wth.codeFCOM < 83 then
            filename = 'dshowern.lua'
        elseif wth.codeFCOM == 85 or wth.codeFCOM == 86 then
            filename = 'dsnown.lua'
        elseif wth.codeFCOM > 94 and wth.codeFCOM < 100 then
            filename = 'dstormn.lua'
        end

        if file.exists(filename) then
            dat.notime = true
            -- OUT('' .. tmp)
            dofile(filename)
        else
            prt('\t\t\t\t\t\t\t\t\tGot Weather Code ', wth.codeFCOM, 'No File!')
        end
    end
end

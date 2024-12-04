do
    local filename = ''
    if wth.codeFCOM then
        if wth.codeFCOM < 2 then
            filename = 'dclearn.lua'
        elseif wth.codeFCOM == 2 then
            filename = 'dcloudn.lua'
        elseif wth.codeFCOM == 3 then
            filename = 'dhmuron.lua'
        elseif wth.codeFCOM == 45 then
            filename = 'd45.lua'
        elseif wth.codeFCOM == 48 then
            filename = 'dfogn.lua'
        elseif wth.codeFCOM > 50 and wth.codeFCOM < 56 then
            filename = 'ddrizzlen.lua'
        elseif wth.codeFCOM == 56 or wth.codeFCOM == 57 then
            filename = 'ddrizzlesupern.lua'
        elseif wth.codeFCOM > 60 and wth.codeFCOM < 69 then
            filename = 'dreinn.lua'
        elseif wth.codeFCOM == 71 then
            filename = 'dsnown.lua'
        elseif wth.codeFCOM == 73 then
            filename = 'dmeteln.lua'
        elseif wth.codeFCOM == 75 then
            filename = 'dviegan.lua'
        elseif wth.codeFCOM == 77 then
            filename = 'dpurgan.lua'
        elseif wth.codeFCOM > 79 and wth.codeFCOM < 83 then
            filename = 'dshowern.lua'
        elseif wth.codeFCOM == 85 or wth.codeFCOM == 86 then
            filename = 'dburann.lua'
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

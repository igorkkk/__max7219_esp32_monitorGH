do
    prt = print
    if not wth then wth = {} end
    local call = function()
        package.loaded['_mh-z19b'], mh = nil, nil
        print('Got co2:', wth.co2)
    end
    local mh = require('ModulesToLFS._mh-z19b')
    mh.askmh(wth, call)
end

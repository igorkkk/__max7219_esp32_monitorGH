uart.setup(2, 9600, 8, uart.PARITY_NONE, uart.STOPBITS_1, {tx = 16, rx = 17})
uart.start(2)
do
    prt = print
    if not wth then wth = {} end
    local call = function()
        package.loaded['_mh-z19b'], mh = nil, nil
        print('Start check MH-Z19\nGot co2:', wth.co2)
        if wth.co2 then dat.mhz19 = true 
        else uart.stop(2)
        end
    end
    local mh = require('ModulesToLFS._mh-z19b')
    mh.askmh(wth, call) 
end


print('Client:', dat.clnt)
dofile 'setglobfn.lua'
dat.pnarod = 1

---- For scd4x:
-- if SDA and SCL then
--     scd4x = require("_scd4x")
--     print('i2c set at pins SDA: ' .. SDA .. ', SCL: ' .. SCL .. ', Speed:', i2c.setup(ID, SDA, SCL, i2c.SLOW))
--     scd4x.start()
--     dat.i2c = true
--     SDA, SCL, ID = nil, nil, nil
-- else
--     dat.noSDC = true
-- end

-- For SCD30
if SDA and SCL then
    scd30 = require("_scd30mod")
    print('i2c set at pins SDA: '..SDA..', SCL: '..SCL..', Speed:', i2c.setup(ID, SDA, SCL, i2c.SLOW))
    scd30.start()
    dat.i2c = true
    SDA, SCL, ID = nil, nil, nil
else
    dat.noSCD = true
end

if TX and RX then
    uart.setup(2, 9600, 8, uart.PARITY_NONE, uart.STOPBITS_1, { tx = TX, rx = RX })
    uart.start(2)
    -- dofile('_uartSPS30.lua')
    TX, RX = nil, nil
else
    dat.noMZH = true
end

max7219 = require('_max7219')
max7219.setup(CS, SCLK, MOSI, MISO)
CS, SCLK, MOSI, MISO = nil, nil, nil, nil
-- max7219.clear()
dofile '_workF.lua'
local a, b = node.bootreason()
if a == 1 and (b == 6 or b == 8) then
    max7219.clear(); dofile 'dstartn.lua'
end
a, b = nil, nil
-- dat.tz=wth.tz
dat.sensnar = dofile('timewh.lua')(900)
dat.sensowtime = nil
if dat.brk and dat.clnt then
    node.task.post(function() dofile('mqttset.lua') end)
end


node.task.post(function() dofile('main.lua') end)

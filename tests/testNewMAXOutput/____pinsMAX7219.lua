-- Works!!!

SCLK = 19
MOSI = 23
MISO = 26
CS = 18


max7219 = require('_max7219')
-- function M.setup(sspin, sclk, mosi, miso)
-- max7219.setup(CS, SCLK, MOSI, MISO)
max7219.setup()
max7219.clear()
max7219.setIntensity(10)
SCLK, MOSI, MISO, CS = nil, nil, nil, nil



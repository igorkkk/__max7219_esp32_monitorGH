--------- wifi -------------
SSID = "AP_Home73"
-- SSID = "IKSYSTEM_TPN"
PASSWD = "7740774077407740"
-------- MAX7219 -----------
SCLK = 19
MOSI = 23
MISO = 26
CS = 18


-- SCLK = 19
-- MOSI = 23
-- MISO = 26
-- CS = 22

------- SDC41 -------
-- SDA = 21
-- SCL = 22
-- ID = i2c.SW

------- SCD30 -------
SDA = 22
SCL = 21
ID = i2c.SW


------- SPS30 -------
-- TX = 17
-- RX = 16

------- MZH19 -------
-- TX = 16
-- RX = 17

------- Lighjt Sensor -------
dat.adcpin = 7   -- GPIO35 
-- dat.adcpin = 4      -- GPIO32 - ADC

dat.ds18pin = 5 -- DS18b20

DEBUG = true

-- TIMEZONE = 'EST-3'

wth.offset = 10800    -- Время, секунды относительно Гринвича 
-- wth.offset = 0
dat.maxbright = 5       -- Максимальная яркость часов, max 15
dat.shownight = true  -- Показ данных ночью, false - не показывать, только часы

-- Is light sensor:
dat.lsens = true -- Есть сенсор освещенности

-- Night Mode
dat.nghtmod = true -- false / true - ночной режим, ночью только время
dat.even = 22      -- ночь наступила в этот час
dat.morn = 6       -- утро наступило

-- Настройки MQTT:
-- dat.brk = '192.168.1.125'
-- dat.brk = '192.168.27.31'
-- dat.brk = '192.168.37.190' -- Брокер
-- dat.port = 1883           -- Порт
dat.brk = 'igorkkk.keenetic.pro' -- Брокер
dat.port = 1777           -- Порт


-- dat.clnt = '/clock2'     -- Имя этих часов для подписки
-- dat.clnt = 'Clock/esp32-MZH19-01'
dat.clnt = 'Clock/sp32_SCD30Mos'
dat.mqlgin = 'MQTT_Login'
dat.mqpass = 'MAQTT_Passwd'

-- dat.mqttemp = 'narod/28B1AED5040000A1' -- Температура на улице

-- https://open-meteo.com/en/docs
-- wth.city = 'Moscow'
dat.lat = '55.7522'
dat.lon = '37.6156'

-- wth.city = 'Novi Sad'
-- dat.lat = '45.2517'
-- dat.lon = '19.8369'


-- Narodmon:
-- old

dat.uuid = "98a66f6b5cae480f99b2357ffea16e8c"
dat.api_key = "QTGNnuvb5cZXM"

------------------
dat.nkey="#EAA3BEFF47A0\n"

-- dat.nkey="#98:f4:ab:dc:aa:34\n#n9S6gW2yPCZdX\n#LAT#59.007180\n#LON#24.799817\n"

-- dat.api_key = 'MY1nAHkc3rX85' -- kivin
-- dat.uuid = 'b3f0472a-cd37-11ed-afa1-0242ac120002' -- new
------------------


-- kivin
-- dat.uuid = "b3f59c9d17d7445791fd002b737919af"
-- dat.api_key = "MY1nAHkc3rX85"

dat.sens = {32191,66230,2013}
-- dat.sens = { 61379, 2439, 30060, 24244, 11113 } -- дача

--

-- Начертание цифр:
digl = {}
digl['0'] = {'00000','01110','10001','10001','10001','10001','10001','01110'}
digl['1'] = {'0000','0010','0110','0010','0010','0010','0010','0111'}
digl['2'] = {'00000','01110','10001','00001','00010','00100','01000','11111'}
digl['3'] = {'00000','01110','10001','00001','00110','00001','10001','01110'}
digl['4'] = {'00000','00010','00110','01010','10010','11111','00010','00010'}
digl['5'] = {'00000','11111','10000','11110','00001','00001','10001','01110'}
digl['6'] = {'00000','01110','10000','11110','10001','10001','10001','01110'}
digl['7'] = {'00000','11111','00001','00001','00010','00100','00100','00100'}
digl['8'] = {'00000','01110','10001','10001','01110','10001','10001','01110'}
digl['9'] = {'00000','01110','10001','10001','01111','00001','10001','01110'}
digl["."]={'0','0','0','0','0','0','0','1'}
digl["+"]={'00000','00000','00100','00100','11111','00100','00100','00000'}
digl["-"]={'0000','0000','0000','0000','1111','0000','0000','0000'}
digl["R"]={'000000','000000','000100','000010','111111','000010','000100','000000'} -- Стрелка вправо
digl[":"]={'0','0','0','1','0','1','0','0'}
digl["H"]={'00011000','00100100','01000010','11000011','01011010','01011010','01000010','01111110'} -- Домик
digl["z"]={'00000','00000','00000','00000','00000','00000','00000','00000'} -- Пробел
digl["C"]={'0000000','0000000','0000000','0100010','1010101','1000101','1010101','0100010'} -- Значок "co" 
digl["p"]={'0000','0000','0000','1110','1001','1001','1110','1000'}
digl["m"]={'000000','000000','000000','100010','110110','101010','101010','101010'}


---------------------- Дальше не менять ------------------------

adc.setup(adc.ADC1 , dat.adcpin, adc.ATTEN_11db)

wth.bright = dat.bright
wth.tz = dat.rtz
dat.tz = dat.rtz
dat.rtz = nil
dat.prt = 1
node.task.post(function() dofile('setglobals.lua') end)


wth.minlux = 300
wth.maxlux = 3500

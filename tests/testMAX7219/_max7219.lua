local M = {}
local nOfM = 4
local SSPin = 18
local DECOD = 0x09
local INTENS = 0x0A
local SCAN = 0x0B
local SHUT = 0x0C
local DIST = 0x0F
-- local device

--[[
Функция string.char	принимает ноль или более целых чисел, преобразует каждое
из них в символ и возвращает строку, в которой все эти символы соединены.	
--]]


local function sendByte(modul, register, data)
	local dt
	local step  = 1
	gpio.write(SSPin, 0)
	while step <= nOfM do
		if step == modul then
			device:transfer(string.char(register, data))
		else
			device:transfer(string.char(0,0))
		end
		step = step + 1
	end
	gpio.write(SSPin, 1)
 end

 function M.sLine(register, dtb)
	local step  = 1
	gpio.write(SSPin, 0)
	while step <= nOfM do
		device:transfer(string.char(register, dtb[step]))
		step = step + 1
	end
	gpio.write(SSPin, 1)
 end
-- SCLK = 19
-- MOSI = 23
-- MISO = 26
-- CS = 18

function M.setup(sspin, sclk, mosi, miso)
	local lsclk = sclk or 19
	local lmosi = mosi or 23
	local lmiso = miso or 26
	local busmaster = spi.master(spi.HSPI, {sclk = lsclk, mosi = lmosi, miso = lmiso})
	-- local device_config = {cs = SSPin, mode = 0, freq = 1000000}
	local device_config = {mode = 0, freq = 10000000}
	device = busmaster:device(device_config)

	SSPin = sspin or SSPin
	gpio.config({gpio={SSPin}, dir=gpio.OUT})
 	gpio.write(SSPin, 1)
	
 
  for i = 1, nOfM do
    sendByte(i, SCAN, 7)
    sendByte(i, DECOD, 0x00)
    sendByte(i, DIST, 0)
    sendByte(i, INTENS, 1)
    sendByte(i, SHUT, 1)
  end
end

function M.setIntensity(intensity)
  for i = 1, nOfM do
    sendByte(i, INTENS, intensity)
  end
end

function M.clear()
  for i = 1, nOfM do
		for ii = 1, 8 do
			sendByte(i, ii, 0)
		end
   end
end

function M.shutdown(sd)
  local sdRg = sd and 0 or 1
  for i = 1, nOfM do
    sendByte(i, SHUT, sdRg)
  end
end

function M.write(chars)
	local step = 1
	for l = 1, 8 do
		gpio.write(SSPin, 0)
		while step <= nOfM do
			device:transfer( string.char(l , chars[step][l]))
			step = step + 1
		end
		gpio.write(SSPin, 1)
		step = 1
	end
end
M.sByte = sendByte
M.sb = sendByte
return M

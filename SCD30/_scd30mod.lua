local scd30 = {}
local addr = 0x61
local pressure = 1013
local prt = prt or print
local writei2c, getbytes, crc_word, crc_valid

writei2c = function(tb)
	i2c.start(0)
	if not i2c.address(0, addr, i2c.TRANSMITTER) then
		prt '\n\n!!!Lost I2C'
		return false
	end
	i2c.write(0, tb)
	i2c.stop(0)
	return true
end

getbytes = function(dig) -- Разлагает число на байты и прилагает crc
	local mbt, lbt, cr
	mbt = bit.rshift(dig, 8)
	lbt = bit.band(dig, 0xFF)
	cr = crc_word(string.char(mbt, lbt), 1)
	return mbt, lbt, cr
end

function scd30.start(press) -- Старт SCD30 с коррекцией давления
	local mbt, lbt, cr
	press = press or pressure
	if press < 700 or press > 1400 then press = pressure end
	mbt, lbt, cr = getbytes(press)
	prt('\n--------\nStart SCD30 at Pressure Correction ' .. press .. ' mBar\nCorrection Data:', mbt, lbt, cr, '\n-------')
	writei2c({ 0x00, 0x10, mbt, lbt, cr })
end

function scd30.stop()
	writei2c({ 0x01, 0x04 })
end

function scd30.setTempOffset(offset) -- Коррекция температуры, шаг 0.01
	local woff, md, ld, cr
	woff = math.floor(offset * 100)
	md, ld, cr = getbytes(woff)
	prt('\nSet SCD30 Temperature Correction ' .. offset .. '°С \nCorrection Data:', md, ld, cr, '\n\n')
	writei2c({ 0x54, 0x03, md, ld, cr })
end

function scd30.altComp(alt) -- Компенсация высоты
	local al, md, ld, cr
	al = alt or 107
	md, ld, cr = getbytes(al)
	prt('\nSet SCD30 Altitude Compensation ' .. alt .. ' m. \nCorrection Data:', md, ld, cr, '\n\n')
	writei2c({ 0x51, 0x02, md, ld, cr })
end

function scd30.reset() -- Soft Reset
	prt('\nReset SCD30 Now!\n')
	writei2c({ 0xD3, 0x04 })
end

function scd30.read(tbl) -- Чтение данных в таблицу
	local data, dt
	dt = {} -- таблица итоговых данных
	nt = {} -- названия данных
	nt[1] = 'co2'
	nt[7] = 'temp_scd30'
	nt[13] = 'humy_scd30'

	writei2c({ 0x03, 0x00 })
	i2c.start(0)
	if not i2c.address(0, addr, i2c.RECEIVER) then
		return nil
	end
	data = i2c.read(0, 18)
	i2c.stop(0)

	if not (crc_valid(data, 18)) then
		prt('\n\n!!! CRC Fall'); return
	end

	for k = 1, #data, 6 do
		s = string.sub(data, k, k + 1)
		s = s .. string.sub(data, k + 3, k + 4)
		dt[nt[k]] = string.format("%0.1f", string.unpack(">f", s))
		if tbl then
			tbl[nt[k]] = dt[nt[k]]
		end
	end
	return dt[nt[1]], dt[nt[7]], dt[nt[13]]
end

function scd30.readfw()
	local data
	writei2c({ 0xD1, 0x00 })
	i2c.start(0)
	if not i2c.address(0, addr, i2c.RECEIVER) then
		return nil
	end
	data = i2c.read(0, 3)
	i2c.stop(0)

	if crc_valid(data, 3) then
		prt('\nFW: ' .. string.byte(data, 1, 1) .. '.' .. string.byte(data, 2, 2))
	else
		prt('Lost Firmware Now!')
	end
end

crc_word = function(data, index)
	local crc = 0xff
	for i = index, index + 1 do
		crc = bit.bxor(crc, string.byte(data, i))
		for j = 8, 1, -1 do
			if bit.isset(crc, 7) then
				crc = bit.bxor(bit.lshift(crc, 1), 0x31)
			else
				crc = bit.lshift(crc, 1)
			end
			crc = bit.band(crc, 0xff)
		end
	end
	return bit.band(crc, 0xff)
end

crc_valid = function(data, length)
	for i = 1, length, 3 do
		if crc_word(data, i) ~= string.byte(data, i + 2) then
			return false
		end
	end
	return true
end
return scd30
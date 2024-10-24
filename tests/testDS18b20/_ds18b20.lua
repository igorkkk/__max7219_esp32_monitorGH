local M={}
M.adrtbl = {}
M.pin = 4
M.del = 750

function M.getaddrs(ttable, call)
    ow.setup(M.pin)
    ow.reset_search(M.pin)
    repeat
        local adr = ow.search(M.pin)
        if(adr ~= nil) then
            table.insert(M.adrtbl, adr)
        end
    until (adr == nil)
    ow.reset_search(M.pin)
	if #M.adrtbl ~= 0 then
		M.askTemp(ttable, call)
	else
		print('No DS18b20!')
		return
	end
end

function M.askTemp(ttable, call)
	ow.setup(M.pin)
    for _, v in pairs(M.adrtbl) do
        ow.reset(M.pin)
        ow.select(M.pin, v)
        ow.write(M.pin, 0x44, 1)
    end
    v = nil

	tmr.create():alarm(M.del, tmr.ALARM_SINGLE, function (t) 
		t = nil
		M.readResult(ttable, call)
	end)
end

function M.readResult(ttable, call)    
    local data, crc, t
    for _, v in pairs(M.adrtbl) do
        ow.reset(M.pin)
        ow.select(M.pin, v)
        ow.write(M.pin,0xBE,1)
        data = ow.read_bytes(M.pin, 9)
		crc = ow.crc8(string.sub(data,1,8))
        if (crc == data:byte(9)) then
            t = (data:byte(1) + data:byte(2) * 256)
            if (t > 32767) then t = t - 65536 end
            t = t * 625 /10000
            --table.insert(ttable, t)
			-------
			local as = ""
            for ii = 1, #v do
                local hx = string.format("%02X", (string.byte(v, ii)))
                as = as ..hx
            end
            -- ttable[as] = t
            -- ttable[as] = string.format("%.2f",t)
			table.insert(ttable, {as, string.format("%.2f",t)})
			-------
		end
    end
	data, crc, t = nil, nil, nil
	if call then call(ttable) end
end

function M.getTemp(ttable, call, pin, del)
	if #M.adrtbl == 0 then
		M.pin = pin or M.pin
		M.del = del or M.del
		M.getaddrs(ttable, call)
	else
		M.askTemp(ttable, call)
	end
end
return M
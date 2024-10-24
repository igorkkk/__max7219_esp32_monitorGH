local M = {}
M.check = function(kl)
	uart.on(2, "data")
	if M.t then M.t:stop(); M.t:unregister(); M.t = nil end
	if kl then print('UART Killed!'); if M.call then M.call() end return end
	M.RAW[1] = 0
	for i = 2, 8 do 
		M.RAW[i] = M.RAW[i] and M.RAW[i] or 0
		M.RAW[1] = M.RAW[1] + M.RAW[i] 
	end
	M.RAW[1] = 256 - bit.band(255, M.RAW[1])
	if M.RAW[1] == M.RAW[9] then
		prt('Sum: ', M.RAW[1], M.RAW[9])
		M.tbl.co2 = M.RAW[3]*256 + M.RAW[4]
	end
	if M.call then M.call() end
end
M.t = tmr.create()
M.t:register(3000, tmr.ALARM_SINGLE, function() M.check(true) end)

M.askmh = function(tbl, call)
	local ustart = false
	if not tbl then return M.check(true)  end
	M.tbl = tbl
	M.RAW = {}
	if call then M.call = call end
	uart.on(2, "data",1,
	    function(data)
	    	if ustart == false and string.byte(data, 1) ~= 255	then 
	    		return
	    	elseif ustart == false then 
	    		ustart = true
	    	end
	    	M.RAW[#M.RAW+1] = string.byte(data, 1)
	    	if #M.RAW == 9 then M.check() end
	    end, 0)
	uart.write(2,255,1,134,0,0,0,0,0,121)
	M.t:start()
end
return M
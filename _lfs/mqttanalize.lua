if killtop and #killtop ~= 0 then
	local com, dt
	com = table.remove(killtop)

	if not com then
		return node.task.post(function() dofile('mqttpub.lua') end)
	end

	if com[1] == 'outtemp' then
		if com[2] then
			dt = tonumber(com[2]) or nil
			if dt then wth.mqttoutt = dt end
		end
	elseif com[1] == 'intemp' then
		if com[2] then
			dt = tonumber(com[2]) or nil
			if dt then wth.mqttint = dt end
		end
	else
		print('No "cmd" to Work')
	end

	com = nil
	node.task.post(function() dofile('mqttanalize.lua') end)
end

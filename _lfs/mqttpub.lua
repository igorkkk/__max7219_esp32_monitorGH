if not dat.broker or not m then return end
wth.heap = node.heap()
local ok, json = pcall(sjson.encode, wth)
wth.heap = nil
if ok then
	prt("MQTT Pub: ", json)
	m:publish(dat.clnt..'/'..'json', json, 2, 0, function(con)
		dat.killm = 0
	end)
	if dat.boot then dofile('sendboot.lua') end
else
	print("failed to encode or send json!")
end
ok, json = nil, nil
collectgarbage()

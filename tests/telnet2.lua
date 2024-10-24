local M = {}
local function telnet_session(socket)
    local node = node
    local stdout 
    local function output_CB(opipe)
        stdout = opipe
        local rec = opipe:read(1400)
        if rec and #rec > 0 then socket:send(rec) end
        return false
    end

    local function onsent_CB(skt)
        local rec = stdout:read(1400)
        if rec and #rec > 0 then skt:send(rec) end
    end

    local function disconnect_CB(skt)
        node.output()
        socket, stdout = nil, nil
    end

    node.output(output_CB, 0)
    socket:on("receive", function(_, rec) node.input(rec) end)
    socket:on("sent", onsent_CB)
    socket:on("disconnection", disconnect_CB)
    print(("Welcome to NodeMCU world (%d mem free, %s)"):format(node.heap(), wifi.sta.getip()))
end

function M.open(self)
    local tmr, wifi, uwrite = tmr, wifi, uart.write
    local t = tmr.create()
    t:alarm(500, tmr.ALARM_AUTO, function()
        if (wifi.sta.status() == wifi.STA_GOTIP) then
            t:unregister()
            t = nil
            print(("Telnet server started (%d mem free, %s)"):format(node.heap(), wifi.sta.getip()))
            M.svr = net.createServer(180)
            M.svr:listen(23, telnet_session)
        else
            uwrite(0, ".")
        end
    end)
end

function M.close(self)
    if self.svr then self.svr:close() end
end
M.open()
return M

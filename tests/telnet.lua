---@diagnostic disable: undefined-doc-name
-- A telnet server  T. Ellison,  June 2019

local M = {}
local modname = ...
---@param socket socket
local function telnet_session(socket)
    local node = node
    local stdout ---@type pipeObj

    ---@param opipe pipeObj
    ---@return boolean
    local function output_CB(opipe) -- upval: socket
        stdout = opipe
        local rec = opipe:read(1400)
        if rec and #rec > 0 then socket:send(rec) end
        return false -- don't repost as the on:sent will do self
    end

    --- Sends data to remote peer
    ---@param skt socket
    local function onsent_CB(skt) -- upval: stdout
        local rec = stdout:read(1400)
        if rec and #rec > 0 then skt:send(rec) end
    end

    local function disconnect_CB(skt) -- upval: socket, stdout
        node.output()
        ---@diagnostic disable-next-line: cast-local-type
        socket, stdout = nil, nil -- set upvals to nil to allow GC
    end

    node.output(output_CB, 0)
    socket:on("receive", function(_, rec) node.input(rec) end)
    socket:on("sent", onsent_CB)
    socket:on("disconnection", disconnect_CB)
    print(("Welcome to NodeMCU world (%d mem free, %s)"):format(node.heap(), wifi.sta.getip()))
end

---@param self table
---@param ssid? string
---@param pwd? string
---@param port number
function M.open(self, ssid, pwd, port)
    local tmr, wifi, uwrite = tmr, wifi, uart.write
    if ssid then
        wifi.setmode(wifi.STATION, false)
        wifi.sta.config { ssid = ssid, pwd = pwd, save = false }
    end
    local t = tmr.create()
    t:alarm(500, tmr.ALARM_AUTO, function()
        if (wifi.sta.status() == wifi.STA_GOTIP) then
            t:unregister()
            t = nil ---@diagnostic disable-line: cast-local-type
            print(("Telnet server started (%d mem free, %s)"):format(node.heap(), wifi.sta.getip()))
            M.svr = net.createServer(180)
            M.svr:listen(port or 23, telnet_session)
        else
            uwrite(0, ".")
        end
    end)
end

function M.close(self)
    if self.svr then self.svr:close() end
    package.loaded[modname] = nil
    modname = nil
end

return M

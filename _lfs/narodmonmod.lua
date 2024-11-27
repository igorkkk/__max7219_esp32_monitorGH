M={}
function M.sendNarod(dataN, tb, call)
    local prt = prt or print
    if type(tb) ~= "table"  then 
        prt("No table")
        return
    end
    local s
    for k, v in pairs(tb) do
        if type(k) == "number" then
            dataN = dataN.."#T"..k.."#"..v.."\n"
        else
            dataN = dataN.."#"..k.."#"..v.."\n"
        end
    end
    dataN = dataN.."##\n"
    prt(dataN)
    conn=net.createConnection(net.TCP, 0)
    conn:on("connection",function(conn, payload)
        conn:send(dataN)
    end)
    conn:on("receive", function(conn, payload)
        prt('Narodmon: '..payload)
        conn:close()
        if call then
           conn = nil
           call()
           collectgarbage()
        end
    end)
    conn:connect(8283,'narodmon.ru')
end
return M

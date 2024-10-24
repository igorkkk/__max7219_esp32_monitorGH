do
    local ttb = function(e, a)
        if not e or type(e) ~= 'table' then e = {} end
        if not a or type(a) ~= 'number' then a = 600 end
        print('\n\n\t\tMake table for ', sec, 'sec\n\n')
        local t = e
        e = {}
        local t = {
            __newindex = function(a, e, o)
                local i = (rtctime.get())
                local a
                if t[e] then
                    if t[e][1] then
                        a = t[e][1]
                    end
                end
                if not a or a ~= o then
                    t[e] = { o, i }
                end
            end,
            __index = function(o, e)
                if not t[e] then return nil end
                if (rtctime.get()) - t[e][2] < a then
                    return t[e][1]
                end
            end,
        }
        setmetatable(e, t)
        return e
    end
    -- return ttb()
    return ttb
end

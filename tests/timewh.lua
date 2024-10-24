do
    -- rtctime.set(0)
    local timetb = function (t, sec)
        if not t or type(t) ~= 'table' then t = {} end
        if not sec or type(sec) ~= 'number' then sec = 600 end
        local _t = t
        t = {}
        local mt = {
            __newindex = function (t, k, v)
                local tm, old_v
                tm = (rtctime.get())
                if _t[k] then
                    if _t[k][1] then
                        old_v = _t[k][1]
                    end
                end
                if not old_v or old_v ~= v then
                    _t[k] = {v, tm}
                end
            end,
            __index = function(t, k)
                if not _t[k] then return nil end
                if (rtctime.get()) - _t[k][2] < sec then
                    return _t[k][1]
               end
            end,
        }
        setmetatable(t, mt)
        return t
    end
    return timetb
end
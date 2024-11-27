if not dat then dat = {} end
if dat.nods then return end
if not wth then wth = {} end
do
    local prt = prt or print
    local e = {}
    local o = 5
    local a = 750
    local function t()
        prt("Got DS18b20: " .. #e)
        if #e > 0 then
            for k, v in pairs(e) do
                prt(k, v[1], v[2])
            end
            -- wth.ds18b20 = string.format("%.1f", e[1][2])
            wth.ds18b20 = tonumber(e[1][2])
        end
        prt('Set wth.ds18b20:', wth.ds18b20)
        ds = nil
        package.loaded["_ds18b20"] = nil
    end
    -- ds = node.LFS._ds18b20()
    ds = require('_ds18b20')
    ds.getTemp(e, t, o, a)
end

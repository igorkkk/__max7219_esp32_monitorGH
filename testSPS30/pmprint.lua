do
    local lines, ppm, SSPin, moveup, point, ddppm
    SSPin = 18
    point = 0

    lines = {}
    lines[1] = { 0x00, 0x18, 0x00, 0x00 }
    lines[2] = { 0x63, 0x24, 0x00, 0x00 }
    lines[3] = { 0x94, 0x84, 0x73, 0x91 }
    lines[4] = { 0x84, 0x85, 0x4A, 0x5B }
    lines[5] = { 0x84, 0x88, 0x4A, 0x55 }
    lines[6] = { 0x84, 0x91, 0x4A, 0x55 }
    lines[7] = { 0x94, 0xA0, 0x73, 0x95 }
    lines[8] = { 0x63, 0x3C, 0x42, 0x15 }

    ppm = tostring(wth.co2)
    ppm = wth.co2 > 999 and ppm or ('z' .. ppm)

    for l = 1, 8 do
        ddppm = {}
        for k = 1, 4 do
            ddppm[k] = dig[(string.sub(ppm, k, k))][l]
        end
        lines[#lines + 1] = ddppm
    end
    moveup = function(tb, br)
        for t = 1, 9 do
            for l = 1, 8 do
                gpio.write(SSPin, 0)
                for k = 1, 4 do
                    device:transfer(string.char(l, tb[l+point][k]))
                end
                gpio.write(SSPin, 1)
            end
            if br then return end
            point = point + 1
        end
    end
    moveup(lines, true)

    tmr.create():alarm(1000, 1, function(t)
        t:stop(); t:unregister(); t = nil
        moveup(lines)
    end)
end

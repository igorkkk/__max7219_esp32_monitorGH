local gotRAW = {}
local startUART = false
local uartdata = {}
local btf, makedata, checksum, byte_stuffing
btf = function(e)
    if type(e) ~= "table" or #e ~= 4 then return end
    local dtu = (string.unpack("f", string.char(e[4], e[3], e[2], e[1])))
    return string.format("%0.1f", dtu)
end


checksum = function(tb)
    --[[
        The checksum is built before byte-stuffing
        and checked after removing stuffed bytes from
        the frame.
    --]]
    local sum = 0
    for k = 1, #tb - 1 do
        sum = sum + tb[k]
    end
    sum = bit.bxor(0xFF, bit.band(0xFF, sum))
    if sum == tb[#tb] then
        prt('\n\n\nSum is OK!')
        return true
    else
        prt('\n\n\t\t\tWrong Sum!')
        return false
    end
end

byte_stuffing = function(tb)
    local ntb = {}
    local insert = 0
    local patt = {}
    patt[0x5E] = 0x7E
    patt[0x5D] = 0x7D
    patt[0x31] = 0x11
    patt[0x33] = 0x13

    for k = 1, #tb do
        if tb[k] == 0x7D then
            insert = patt[tb[k + 1]]
        end
        if tb[k] ~= 0x7D then
            if insert ~= 0 then
                ntb[#ntb + 1] = insert
                insert = 0
            else
                ntb[#ntb + 1] = tb[k]
            end
        end
    end
    return ntb
end

makedata = function(tb)
    prt('\n\nWork Makedata Function')
    local dtb = {}
    local pointer = 1
    local pat = {}
    pat[1] = 'pm1'; pat[2] = 'pm2_5'; pat[3] = 'pm4'
    pat[4] = 'pm10'; pat[5] = 'npm0_5'; pat[6] = 'npm1'
    pat[7] = 'npm2_5'; pat[8] = 'npm4'; pat[9] = 'npm10'
    pat[10] = 'tpz'

    for k = 5, 44 do
        dtb[#dtb + 1] = tb[k]
        -- prt(k, tb[k])
        if #dtb == 4 then
            local ddig = btf(dtb)
            -- prt('ddig', ddig, 'Patt', pat[pointer])
            wth[pat[pointer]] = ddig
            dtb = {}
            pointer = pointer + 1
        end
    end
    uartdata = {}
    prt('\n\n\tNow Got Data From SPS30')
end

uart.on(2, "data", 1,
    function(data)
        local ok = false
        local bt = string.byte(data, 1)
        --prt(string.format("bt = 0x%02X", bt))
        if startUART == false and bt ~= 0x7E then
            return
        elseif startUART == false then
            startUART = true
            gotRAW = {}
            return
        end
        if bt == 0x7E then
            uartdata = byte_stuffing(gotRAW)
            ok = checksum(uartdata)
            prt("Got ", ok, " Data from SPS30")
            startUART = false
            if #uartdata > 40 then
                makedata(uartdata)
            else
                ok = uartdata[3]
                if ok == 0 then
                    prt('\n\n\tCommand is Ok! No error.')
                else
                    local errr = string.format("bt = 0x%02X", ok)
                    prt('Command Error:', string.format("0x%02X", ok))
                    if ok == 0x43 then prt('\n\n\tCommand not allowed in current state') end
                    if ok == 0x03 then prt('\n\n\tNo access right for command') end
                end
            end
            return
        end
        gotRAW[#gotRAW + 1] = bt
        -- prt(string.format("\t\t0x%02X,", bt))
    end, 0)

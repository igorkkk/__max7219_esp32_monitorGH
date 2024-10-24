--[[
NoviSad
B'00000000000000000000000000000000'
B'01001000000000001001100000000000'
B'01001001100100100010010011101110'
B'01101010010100101010000100101001'
B'01011010010100101001100100101001'
B'01001010010100101000010111101001'
B'01001010010100101010010100101001'
B'01001001100011001001100100101110'
--]]

-- function b(s)
--     return tonumber(string.gsub(s, "_", ""), 2)
-- end

-- Для разбора генератора матрицы:
do
    local function B(s)
        local line, convertB
        line = {}
        convertB = function(str)
            -- return tonumber(str, 2)
            return tonumber(string.gsub(str, "_", ""), 2)
        end
        if #s <= 8 then return convertB(s) end

        if #s == 32 then
            local st = 1
            local ed = 8
            for i = 1, 4 do
                -- print('st, ed:',st, ed)
                line[i] = convertB(string.sub(s, st, ed))
                st = st + 8; ed = ed + 8
            end
            print('{' .. line[1] .. ',' .. line[2] .. ',' .. line[3] .. ',' .. line[4] .. '},')
        end
    end
    -- print(b'1001_0001' + b'10')
    -- print(b'10010001' + b'10')
    -- print(tonumber(0x93))
    -- NS
    B'00000000000000000000000000000000'
    B'01001000000000001001100000000000'
    B'01001001100100100010010011101110'
    B'01101010010100101010000100101001'
    B'01011010010100101001100100101001'
    B'01001010010100101000010111101001'
    B'01001010010100101010010100101001'
    B'01001001100011001001100100101110'



end

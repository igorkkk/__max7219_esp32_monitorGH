----- Setup -----
--[[
Файл запускает SPS30, через 30 секунд запрашивает данные и останавливает его работу. 
--]]

TX = 17
RX = 16

prt = function(...) if DEBUG then print(...) end end
DEBUG = true

if not dat then dat = {} end
if not wth then wth = {} end
if dat.spsworks == true then return end

if not dat.txSPS then dat.txSPS = TX end
if not dat.rxSPS then dat.rxSPS = RX end

if not dat.uart2 then
    uart.setup(2, 115200, 8, uart.PARITY_NONE, uart.STOPBITS_1, {tx = dat.txSPS, rx = dat.rxSPS})
    uart.start(2)
    dofile('_uartSPS30.lua')
    dat.uart2 = true
end

TX, RX = nil, nil

---

dat.spsworks = true
local comtb = {}
comtb.strt_ms = {0x7E, 0x00, 0x00, 0x02, 0x01, 0x03, 0xF9, 0x7E}
comtb.stop_ms = {0x7E, 0x00, 0x01, 0x00, 0xFE, 0x7E}
comtb.read_ms = {0x7E, 0x00, 0x03, 0x00, 0xFC, 0x7E}

print('\n\n\tAsk Start PSP30:', unpack(comtb.strt_ms), '\n')
uart.write(2, table.unpack(comtb.strt_ms))

local worktmr = tmr.create()

local function stop(t)
    print('\n\n\tAsk Stop SPS30:', table.unpack(comtb.stop_ms), '\n')
    uart.write(2, table.unpack(comtb.stop_ms))    
end

local function read(t)
    print('\n\n\tAsk Read SPS30:', table.unpack(comtb.read_ms), '\n')
    uart.write(2, table.unpack(comtb.read_ms))    
end

local worktb = {}
worktb[1] = read
worktb[2] = stop
local pointer = 1

worktmr:alarm(30000, tmr.ALARM_AUTO, function (t)
    worktb[pointer]()
    pointer = pointer + 1
    worktmr:stop()
    worktmr:interval(2000)
    worktmr:start()
    if pointer == 3 then
        t:stop()
        worktmr:unregister()
        t = nil
        worktmr = nil
        dat.spsworks = false
        prt('\t\t\t\tSPS30 is Stopped')
    end
end)

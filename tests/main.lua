do
function gettime()
    dat.countint = dat.countint + 1
    tm = rtctime.epoch2cal(rtctime.get() + dat.tz * 60 * 60)
    if tm['year'] == 1970 then
        maketemp();
        return
    end
    if not dat.starttm then dat.starttm = (rtctime.get()) end ----
    local e = '' .. tm.hour
    local t = '' .. tm.min

    if #e == 1 and dat.iszero then 
        e = '0' .. e 
    elseif #e == 1 and not dat.iszero then
        e = 'z' .. e 
    end


    if #t == 1 then t = '0' .. t end
    dat.lasttime = e .. t
    if dat.mnow == dat.lasttime then
        if dat.dotp then
            dat.dotp = false
            dat.dot1 = bit.clear(dat.dot1, 0)
            dat.dot2 = bit.clear(dat.dot2, 0)
        else
            dat.dotp = true
            dat.dot1 = bit.set(dat.dot1, 0)
            dat.dot2 = bit.set(dat.dot2, 0)
        end
        max7219.sb(2, 4, dat.dot1)
        max7219.sb(2, 6, dat.dot2)
        return
    else
        dat.mnow = dat.lasttime
        printdata(dat.lasttime, ':')
    end
    if dat.countint > dat.int then
        dat.countint = 0
        play()
    end
    
end

local bigdig = false 

tik = tmr.create()
tik:alarm(1000, 1, gettime)

function play()
    if dat.nghtmod then
        if dat.nghtmod == 'AUTO' and dat.lsens then
            local lx = adc.read(0)
            if lx < 30 then 
                dat.night = true
            else
                if dat.night then 
                    dat.askw = 0
                    dat.night = false
                end
            end
        else
            if tm.hour >= dat.even or tm.hour <= dat.morn then
                dat.night = true
            else
                if dat.night then 
                    dat.askw = 0
                    dat.night = false
                end
            end
        end
    end 

    if not dat.lsens and dat.morn and dat.even then
        if tm.hour > dat.morn and tm.hour < dat.even and not dat.intens then
            dat.intens = true
            max7219.setIntensity(dat.bright)
            --dofile('_bigdigit.lua')
        elseif tm.hour >= dat.even and dat.intens then
            dat.intens = false
            max7219.setIntensity(0)
            --dofile('_smalldigit.lua')
        end

    else
        wth.lux = 1024 - adc.read(0)
        if wth.lux > wth.maxlux then wth.maxlux = wth.lux end
        if wth.lux < wth.minlux then wth.minlux = wth.lux end
        print("\n\t\t\t\t\tGot Lux:", wth.lux)
        
        
        if wth.lux >500 then
            wth.bright = dat.bright
        elseif wth.lux <= dat.nsens then
            wth.bright = 0
        else 
            wth.bright = math.floor(wth.lux/500*dat.bright)    
        end


        print("\t\t\t\t\tSet Bright:", wth.bright)
        max7219.setIntensity(wth.bright)
    end

    print(node.heap())

    if dat.digch then 
        if dat.night and not bigdig then 
            dofile('_bigdigit.lua')
            bigdig = true
        elseif not dat.night and bigdig then
            dofile('_smalldigit.lua')
            bigdig = false
        end
    end
    
    if not dat.night then
        local e = 2000
        if not dat.night and (wth.narod or wth.avgnow or wth.mqtttemp) then
            tik:stop()
            if dat.anm then
                dat.call = maketemp
                if dat.askw % 6 == 0 then
                    e = 3000
                    askfl('moveupcall.lua')
                elseif dat.askw % 3 == 0 then
                    e = 3000
                    askfl('moveleftcall.lua')
                else
                    dat.call = nil
                    maketemp()
                end
            else
                maketemp()
            end
        end

        tmr.create():alarm(e, 0, function(e)
            e = nil
            if wth.codef and wth.codef > 99 and wth.codef < 1283 then
            -- if wth.codef and wth.codef > 99 and wth.codef < 1283 then
                askfl('prtForecast.lua')
            else
                askfl('prtHome.lua')
            end
        end)
    else
        local nowtm = rtctime.get() 
        if nowtm - dat.nghtsent > 60 then
            askfl('askds18b20.lua')
            askfl("mqttpub.lua", wth)
            dat.nghtsent = nowtm
        end
    end
end

-- tmrwth = tmr.create()
-- tmrwth:alarm(dat.int * 1000, 1, play)
end
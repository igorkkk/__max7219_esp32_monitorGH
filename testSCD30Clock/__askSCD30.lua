do
    SDA = 22
    SCL = 21
    if not dat then dat = {} end
    if not wth then wth = {} end

    if not dat.sda then dat.sda = SDA end
    if not dat.scl then dat.scl = SCL end
    if not dat.id then dat.id = i2c.SW end -- software interface
    if not dat.device_addr then dat.device_addr = 0x62 end
    SDA, SCL = nil, nil

    asksensor = function()
        local co2, temp, humi = scd30.read(wth)
        print('co2:', co2,'Temperature:', temp, 'Humidity:', humi)
    end

    if dat.sda and dat.scl and not dat.i2c then
        scd30 = require("_scd30mod")
        print('i2c set at pins SDA: '..dat.sda..', SCL: '..dat.scl..', Speed:', i2c.setup(dat.id, dat.sda, dat.scl, i2c.SLOW))
        scd30.start()
        dat.i2c = true
    else
        print('\t\t\t\ti2c Bus Ready')
    end

    asksensor()
    -- tmr.create():alarm(15000, 1, asksensor)
end
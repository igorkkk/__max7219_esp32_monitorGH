do
    local scd30kill, co2, temp, humi
    if not wth then wth = {} end
    scd30 = require("_scd30mod")

    scd30kill = function()
        package.loaded['scd30mod'] = nil
        scd30 = nil
    end

    co2, temp, humi = scd30.read(wth, scd30kill)
    print('co2:', co2, 'Temperature:', temp, 'Humidity:', humi)
end

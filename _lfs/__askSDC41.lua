if dat.noSDC then return end
do
    local co2, temp, humi = scd4x.read(wth)
    prt('co2:', co2,'Temperature:', temp, 'Humidity:', humi)
end
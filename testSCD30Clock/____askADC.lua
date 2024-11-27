--[[
    channel When using adc.ADC1: 0 to 7. 
    0: GPIO36, 
    1: GPIO37, 
    2: GPIO38, 
    3: GPIO39, 
    4: GPIO32, 
    5: GPIO33, 
    6: GPIO34, 
    7: GPIO35
    
    atten One of following constants
    adc.ATTEN_0db The input voltage of ADC will be reduced to about 1/1 (1.1V when VDD_A=3.3V)
    adc.ATTEN_2_5db The input voltage of ADC will be reduced to about 1/1.34 (1.5V when VDD_A=3.3V)
    adc.ATTEN_6db The input voltage of ADC will be reduced to about 1/2 (2.2V when VDD_A=3.3V)
    adc.ATTEN_11db The input voltage of ADC will be reduced to about 1/3.6 (3.9V when VDD_A=3.3V, maximum voltage is limited by VDD_A)
--]]

channelADC = 7 -- GPIO35 
adc.setup(adc.ADC1 , channelADC, adc.ATTEN_11db)

getADC = function ()
    local lux = 4095 - adc.read(adc.ADC1, channelADC)
    print(lux)
end

getADC()
tmr.create():alarm(5000, tmr.ALARM_AUTO, getADC)

-- print(4095 - adc.read(adc.ADC1, 7))
do
    SDA = 22
    SCL = 21
    -- i2c.SW end -- software interface
    print('i2c set at pins SDA: ' .. SDA .. ', SCL: ' .. SCL .. ', Speed:',
    i2c.setup(i2c.SW, SDA, SCL, i2c.SLOW))
    SDA, SCL = nil, nil   
end
## Часы на матрице MAX7219 и ESP32 с модулями SCD30, SDC41, MH-Z19 и датчиком ds18b20.

Источники знаний:

[MAX7219](https://download.mikroe.com/documents/datasheets/MAX7219.pdf)

[SCD30](https://sensirion.com/media/documents/4EAF6AF8/61652C3C/Sensirion_CO2_Sensors_SCD30_Datasheet.pdf)

[SDC41](https://sensirion.com/media/documents/E0F04247/631EF271/CD_DS_SCD40_SCD41_Datasheet_D1.pdf)

[MH-Z19](https://www.winsen-sensor.com/d/files/PDF/Infrared%20Gas%20Sensor/NDIR%20CO2%20SENSOR/MH-Z19%20CO2%20Ver1.0.pdf)

[ds18b20](https://amperkot.ru/static/3236/uploads/datasheets/DS18B20%20datasheet.pdf)


Часы ветки настроены с датчиками SCD30 и DS18b20. 

Драйверы других датчиков находятся в папке ModulesToLFS и требуют коррекции в файлах _setuser.lua, setglobals.lua, main.lua.
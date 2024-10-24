a = '<weatherdata><location><name>Moscow</name><type></type><country>RU</country><timezone>10800</timezone><location altitude="0" latitude="55.7522" longitude="37.6156" geobase="geonames" geobaseid="524901"></location></location><credit></credit><meta><lastupdate></lastupdate><calctime>0</calctime><nextupdate></nextupdate></meta><sun rise="2023-04-07T02:45:58" set="2023-04-07T16:17:14"></sun><forecast><time from="2023-04-07T18:00:00" to="2023-04-07T21:00:00"><symbol number="803" name="broken clouds" var="04n"></symbol><precipitation probability="0"></precipitation><windDirection deg="92" code="E" name="East"></windDirection><windSpeed mps="3.22" unit="m/s" name="Light breeze"></windSpeed><windGust gust="8.41" unit="m/s"></windGust><temperature unit="celsius" value="4.42" min="4.42" max="4.69"></temperature><feels_like value="1.65" unit="celsius"></feels_like><pressure unit="hPa" value="1028"></pressure><humidity value="52" unit="%"></humidity><clouds value="broken clouds" all="67" unit="%"></clouds><visibility value="10000"></visibility></time><time from="2'

i, o = string.match(a, ':00"><symbol number="(%d+).*us" value="(%p*%d+%.*%d*)')

print(i, o)



function printdata(i, a)
    print('data, sep', i, a)
    local o
    local e = {}
    local function n(a, t)
        for e = 1, 8 do
            a[e] = dig[t][e]
        end
    end
    for t = 1, 4 do
        o = string.sub(i, t, t)
        e[t] = {}
        n(e[t], o)
    end
    o = nil
    max7219.write(e)
    e, n = nil, nil
end
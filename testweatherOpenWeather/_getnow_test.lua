--https://api.openweathermap.org/data/2.5/weather?lat=45.26&lon=19.83&units=metric&appid=
e = '{"coord":{"lon":19.8322,"lat":45.2607},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}],"base":"stations","main":{"temp":13.38,"feels_like":13.07,"temp_min":11.98,"temp_max":13.38,"pressure":1019,"humidity":88,"sea_level":1019,"grnd_level":1004},"visibility":10000,"wind":{"speed":2.04,"deg":75,"gust":2.93},"clouds":{"all":16},"dt":1726558881,"sys":{"type":2,"id":2023026,"country":"RS","sunrise":1726546915,"sunset":1726591706},"timezone":7200,"id":3194360,"name":"Novi Sad","cod":200}'
d, nowt, press, hum, wind, timezone = string.match(e,  '"weather":%[{"id":(%d+).*"main":{"temp":(%p*%d+%.-%d*),.*"pressure":(%d+),.*"humidity":(%d+),.*"speed":(%d+%.-%d*),.*"timezone":(%d+),')
print(d, nowt, press, hum, wind, timezone)


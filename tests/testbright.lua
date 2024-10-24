bright = 11
dat = {}
dat.bright = 11

wth = {}
wth.maxlux = 1024
wth.minlux = 280

wth.lux = 350


bright = dat.bright
if wth.lux < wth.maxlux then
    bright = math.floor((dat.bright/(wth.maxlux - wth.minlux)) * (wth.lux - wth.minlux))
    bright = bright < 0 and 0 or bright
end

print(dat.bright/(wth.maxlux - wth.minlux))
print('bright now', bright, 'lux now: ', wth.lux )

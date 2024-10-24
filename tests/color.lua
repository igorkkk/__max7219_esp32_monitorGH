fgColor = {
    red    = '\027[0;31m',
    green  = '\027[0;32m',
    yellow = '\027[0;33m',
    blue   = '\027[0;34m',
    cyan   = '\027[0;36m',
    reset  = '\027[0m',
}
local data = {
    red    = ('%s$> Red    |%s\n'),
    green  = ('%s$> Green  |%s\n'),
    yellow = ('%s$> Yellow |%s\n'),
    blue   = ('%s$> Blue   |%s\n'),
    cyan   = ('%s$> Cyan   |%s\n'),
}
for color, message in pairs(data) do
    print(message:format(fgColor[color], fgColor.reset))
end